output "private_ip" {
  description = "private ip address"
  value       = aws_instance.postgres.private_ip
}