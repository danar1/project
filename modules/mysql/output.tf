output "mysql_private_ip" {
  description = "mysql private ip"
  value       = aws_instance.mysql.*.private_ip
}