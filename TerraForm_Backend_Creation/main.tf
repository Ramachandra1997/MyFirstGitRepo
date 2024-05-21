resource "aws_instance" "TerraForm_backend" {
    ami = var.OS
    instance_type = var.Processor
    key_name = var.KeyPair
    vpc_security_group_ids = [ var.SecGroupId ]
    provider = aws.us-east-1
    tags = {
      Name = "BackendintegrationTerraform"
    }
}
/*
resource "aws_s3_bucket" "TerraformBucket" {
  bucket = "terraformbucket0367"
  provider = aws.us-east-1
}

resource "aws_dynamodb_table" "Terraform_lock" {
  name = "terraformlock0367"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
*/