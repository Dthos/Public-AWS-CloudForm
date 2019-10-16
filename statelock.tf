# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

# terraform.tf
terraform {
 backend “s3” {
 encrypt = true
 bucket = "terraform-remote-state-storage-s3"
 dynamodb_table = "terraform-state-lock-dynamo"
 region = us-west-2
 key = path/to/state/file
 }
}