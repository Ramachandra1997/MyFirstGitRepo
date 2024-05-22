provider "aws" {
    region = "us-east-1"
}

variable "OS" {
  description = "operating system"
}
variable "processor" {
  description = "instance type"
}

resource "aws_instance" "server1" {
    ami = var.OS
    instance_type = var.processor
}