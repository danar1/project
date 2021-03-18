##################################################################################
# output
##################################################################################

output "prometheus_private_ip" {
  description = "prometheus private ip"
  value       = aws_instance.prometheus.private_ip
}

output "grafana_private_ip" {
  description = "grafana private ip"
  value       = aws_instance.grafana.private_ip
}

output "grafana_lb_dns" {
  description = "grafana lb dns"
  value       = aws_lb.grafana.dns_name
}


