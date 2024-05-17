output "Public-Ip" {
    value = aws_instance.web.public_ip
}
output "Instance-name" {
    value = aws_instance.web.tags
  
}