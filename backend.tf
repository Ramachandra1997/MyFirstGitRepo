terraform {
  backend "s3" {
    bucket = "terraformbucket0367"
    key = "Rama2/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformlock0367"
  }
}