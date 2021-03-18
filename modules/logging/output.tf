##################################################################################
# output
##################################################################################

output "elasticsearch_private_ip" {
  description = "elasticsearch private ip"
  value       = aws_instance.elasticsearch.private_ip
}

output "kibana_private_ip" {
  description = "kibana private ip"
  value       = aws_instance.kibana.private_ip
}

output "kibana_lb_dns" {
  description = "kibana lb dns"
  value       = aws_lb.kibana.dns_name
}


