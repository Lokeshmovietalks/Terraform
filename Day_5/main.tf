provider "aws" {
  region = "ap-southeast-2"
}

variable "vpc" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "myVPC" {
  cidr_block = var.vpc
}

resource "aws_key_pair" "myKey" {
    key_name = "terraform-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_subnet" "Sub1" {
  vpc_id = aws_vpc.myVPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-2a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVPC.id
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RTA" {
  subnet_id = aws_subnet.Sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "SG1" {
  vpc_id = aws_vpc.myVPC.id
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "name" {
  ami = "ami-0822a7a2356687b0f"
  instance_type = "t2.micro"
  key_name = aws_key_pair.myKey.key_name
  subnet_id = aws_subnet.Sub1.id
  security_groups = [ aws_security_group.SG1.id ]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ec2-user/app.py"
  }

  provisioner "remote-exec" {
    inline = [ 
        "echo 'Hello welcome to the ec2-instance'",
        "sudo yum update -y",
        "sudo yum install -y python3-pip",
        "cd /home/ec2-user",
        "sudo pip3 install flask",
        "sudo nohup python3 /home/ec2-user/app.py > app.log 2>&1 &"
     ]
  }
}