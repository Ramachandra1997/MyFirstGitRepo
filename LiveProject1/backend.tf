terraform {
  backend "s3" {
    bucket = "terraformbucket0367"
    key = "LiveProject/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformlock0367"
  }
}