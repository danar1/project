variable "key_name" {
  description = "project key pair name"
  type        = string
}

variable "ssh_security_group_ids" {
  description = "list of security group ids"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags for all the resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

variable "public_subnets" {
  description = "list of public subnet ids"
  type        = list(string)
}

variable "private_subnets" {
  description = "list of private subnet ids"
  type        = list(string)
}

# variable "nat_gw_object" {
#   description = "The NAT gw object, the jenkins master depends on"
#   type        = object({})
# }

variable "nat_gw_id" {
  description = "The NAT gw id, the jenkins master depends on"
  type        = string
}

variable "bastion_public_ips" {
  description = "list of bastion server public ips"
  type        = list(string)
}

variable "key_file" {
  description = "key file name"
  type        = string
}

variable "port_80_ips" {
  description = "list of ips allowed to access jenkins ALB"
  type        = list(string)
}

variable "jenkins_agent_count" {
  description = "The amount of jenkins agents"
  type        = number
}

variable "eks_cluster_id" {
    description = "The EKS cluster id"
  type    = string
}

variable "jenkins_ec2_policy_name" {
  description = "Jenkins ec2 policy name"
  type        = string
}

variable "jenkins_ec2_role_name" {
  description = "Jenkins ec2 role name"
  type        = string
}







