provider "aws" {
  alias="first_zone"
	region="ap-southeast-2"
}
provider "aws" {
  alias="second_zone"
  region="ap-southeast-1"
}
variable "type"{
  description="This is a instance_type"
  type=string
  default="t2.micro"
}
resource "aws_instance" "example" {
	ami="ami-0e8ebb0ab254bb563"
  provider=aws.second_zone
	instance_type=var.type
}
output "public_ip"{
  description="this is the instance public ip"
  value=aws_instance.example.public_ip
}
