##################################################################################
# EKS
##################################################################################

output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

# output "kubectl_config" {
#   description = "kubectl config as generated by the module."
#   value       = module.eks.kubeconfig
# }

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

##################################################################################
# ALB, Instances, Role
##################################################################################

output "bastian_public_ip" {
  description = "bastian public ip"
  value       = aws_instance.bastion.*.public_ip
}

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