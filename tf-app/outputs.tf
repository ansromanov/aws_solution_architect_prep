output "public_instance_ip" {
  value = aws_instance.instance_public.public_ip
}
output "public_instance_dns" {
  value = aws_instance.instance_public.public_dns
}

output "private_instance_ip" {
  value = values(aws_instance.instance_private)[*].private_ip
}