provider "aws"{
    region = "ap-southeast-2"
}

resource "aws_s3_bucket" "StateFile" {
  bucket = "statefiledemo"
  bucket_prefix = "statefiledemo/terraform/"
}