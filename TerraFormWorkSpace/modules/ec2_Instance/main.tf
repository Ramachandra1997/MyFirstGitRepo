provider "aws" {
    region = "us-east-1"
}
provider "vault" {
  address = "http://54.163.40.207:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id = "f06c2aa8-ed59-66c0-b912-c0163ebefaeb"
      secret_id = "30b49af5-20aa-65b8-b7f0-e2b176fe2e01"
    }
  }
} 

data "vault_kv_secret_v2" "vaultusername" {
  mount = "KeyStore"
  name = "terraform"
}

variable "OS" {
  description = "operating system"
}
variable "processor" {
  description = "instance type"
}

variable "KeyPair" {
    default = "ConnectKey"
}
variable "SecGroupId" {
 default = "sg-0030c841b212cf15d" 
}
variable "ServerName" {
  description = "ec2 server name"
  type = string
}

resource "aws_instance" "server1" {
    ami = var.OS
    instance_type = var.processor
    vpc_security_group_ids = [var.SecGroupId]
    key_name = var.KeyPair
    tags = {
      Name = var.ServerName
      Secret = data.vault_kv_secret_v2.vaultusername.data["createdBy"]
    }

}