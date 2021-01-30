output "jenkins_master_lb_dns" {
  description = "Jenkins master lb dns"
  value       = aws_lb.jenkins.dns_name
}

output "jenkins_master_private_ip" {
  description = "Jenkins master private ip"
  value       = aws_instance.jenkins_master.private_ip
}

output "jenkins_agents_private_ip" {
  description = "Jenkins agents private ip"
  value       = aws_instance.jenkins_agent.*.private_ip
}

output "jenkins_agents_role_arn" {
  description = "Jenkins agents role arn"
  value       = aws_iam_role.ec2-iam-role.arn
}