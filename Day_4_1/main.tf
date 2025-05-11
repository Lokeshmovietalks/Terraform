provider "aws"{
    region = "ap-southeast-2"
}

resource "aws_instance" "name" {
  ami = "ami-0822a7a2356687b0f"
  instance_type = "t2.micro"
}