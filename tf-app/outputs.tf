output "public_instance_ip" {
  value = aws_instance.instance_public.public_ip
}
output "private_instance_ip" {
  value = aws_instance.instance_private.private_ip
}