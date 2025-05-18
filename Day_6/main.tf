provider "aws"{
    region = "ap-southeast-2"
}
resource "aws_instance" "name" {
  ami = var.ami_value
  instance_type = var.instance_value
}