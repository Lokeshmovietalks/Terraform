provider "aws" {
  region = "ap-southeast-1"
}
module "ec2-instance" {
  source = "./Modules/ec2-instance"
  ami_value = "ami-0822a7a2356687b0f"
  instance_type = "t2.micro"
}