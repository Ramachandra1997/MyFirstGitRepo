resource "aws_instance" "web" {
  ami = var.OS
  instance_type = var.Processor
  key_name = var.KeyPair
  vpc_security_group_ids = [ var.SecGroupId ]
  provider = aws.us-east-1
  tags = {
    Name = "terraform_Creation"
  }
}