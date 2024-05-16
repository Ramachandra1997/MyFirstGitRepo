terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "${var.OS}"
  instance_type = "${var.Processor}"
  key_name = "${var.KeyPair}"
  vpc_security_group_ids = ["${var.SecGroupId}"]
  tags = {
    Name = "terraform_Creation"
  }
}