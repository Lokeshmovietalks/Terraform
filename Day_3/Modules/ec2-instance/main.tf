provider "aws"{
    region="ap-southeast-2"
}
resource "aws_instance" "example"{
    ami=var.ami_value
    instance_type = var.instance_type
}