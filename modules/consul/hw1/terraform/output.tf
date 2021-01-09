output "consul_servers_public_dns" {
  value = aws_instance.consul_server.*.public_dns
}

output "consul_agents_public_dns" {
  value = aws_instance.consul_agent.*.public_dns
}

output "consul_servers_public_addresses" {
    value = aws_instance.consul_server.*.public_ip
}
output "consul_servers_private_addresses" {
    value = aws_instance.consul_server.*.private_ip
}

output "consul_agents_public_addresses" {
    value = aws_instance.consul_agent.*.public_ip
}
output "consul_agents_private_addresses" {
    value = aws_instance.consul_agent.*.private_ip
}

output "ansible_server_public_address" {
    value = aws_instance.ansible-server.*.public_ip
}
