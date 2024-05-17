resource "aws_instance" "TerraForm_backend" {
    ami = var.OS
    instance_type = var.Processor
    key_name = var.KeyPair
    vpc_security_group_ids = [ var.SecGroupId ]
    tags = {
      name = "TerraformBackendIntegration"
    }
}