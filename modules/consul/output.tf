output "consul_alb_dns" {
  description = "consul alb dns"
  value       = aws_lb.consul-lb.dns_name
}

output "consul_servers_private_ips" {
  value = data.aws_instances.consul-servers.private_ips
}
