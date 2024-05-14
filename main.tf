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
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform_Creation"
  }
}