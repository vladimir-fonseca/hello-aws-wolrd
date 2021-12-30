
output "web_instance_ip" {
  value = aws_eip.web.public_ip
}
