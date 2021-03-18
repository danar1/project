output "consul_alb_dns" {
  description = "consul alb dns"
  value       = aws_lb.consul-lb.dns_name
}

output "consul_servers_private_ips" {
  value = data.aws_instances.consul-servers.private_ips
}

output "consul_security_group" {
  value = aws_security_group.consul-launch-template-sg.id
}

output "consul_role" {
  value = aws_iam_instance_profile.consul-instance-profile.name
}


