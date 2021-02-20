output "ansible_private_ip" {
  description = "ansible private ip"
  value       = aws_instance.ansible.*.private_ip
}

output "ansible_security_group" {
  description = "ansible security group"
  value       = aws_security_group.ansible-sg
}