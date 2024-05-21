output "Public-Ip" {
    value = aws_instance.LiveProjectServer.public_ip
}
output "Instance-name" {
    value = aws_instance.LiveProjectServer.tags
  
}