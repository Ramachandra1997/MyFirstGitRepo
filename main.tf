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
    region = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "${var.OS}"
  instance_type = "${var.Processor}"

  tags = {
    Name = "terraform_Creation"
  }
}