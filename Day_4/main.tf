provider "aws"{
    region = "ap-southeast-2"
}

resource "aws_s3_bucket" "StateFile" {
  bucket = "statefiledemo"
}

resource "aws_dynamodb_table" "Lock" {
  name = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}