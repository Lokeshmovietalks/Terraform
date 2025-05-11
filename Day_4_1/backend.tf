terraform {
  backend "s3" {
    bucket = "statefiledemo-lokesh-220299"
    key = "lokesh/statefile.tfstate"
    region = "ap-southeast-2"
  }
}