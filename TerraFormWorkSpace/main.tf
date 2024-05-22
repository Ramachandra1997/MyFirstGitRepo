provider "aws" {
    region = "us-east-1"
}

variable "os" {
    description = "operating system"
}
variable "configuration" {
    description = "configuration"
    type = map(string)
    default = {
      "dev" = "t2.micro"
      "perf" = "t2.micro"
    }
}


module "ec2_creation" {
    source = "./modules/ec2_Instance"
    OS = var.os
    processor = lookup(var.configuration, terraform.workspace, "t2.micro" )
}
