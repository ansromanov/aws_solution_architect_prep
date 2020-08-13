output "private_instance_ip" {
  value = values(aws_instance.instance_private)[*].private_ip
}