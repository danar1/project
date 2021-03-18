##################################################################################
# VARIABLES 
##################################################################################

# vpc module vars
variable "aws_region" {
  description = "AWS region"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "map_public_ip_on_launch" {
  type    = bool
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnet"
  type        = map(string)
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnet"
  type        = map(string)
}

variable "gw_tags" {
  description = "Additional tags for the GW"
  type        = map(string)
}

variable "eip_tags" {
  description = "Additional tags for the S3 EIP"
  type        = map(string)
}

variable "nat_tags" {
  description = "Additional tags for the NAT"
  type        = map(string)
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route table"
  type        = map(string)
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route table"
  type        = map(string)
}

# ec2 module tags
variable "instance_type" {
  type    = string
}

# To do - need health_check var for jenkins and consul 
# variable "health_check" {
#   type    = map(any)
#   default = {
#         enabled             = true
#         interval            = 30
#         path                = "/"
#         port                = 80
#         protocol            = "HTTP"
#         timeout             = 5
#         healthy_threshold   = 5
#         unhealthy_threshold = 2
#   }
# }


# s3 module vars
variable "bucket" {
  type    = string
}

variable "acl" {
  type    = string
}

variable "s3_to_ec2_role_name" {
  type    = string
  default = "ops-ec2-iam-role"
}

variable "s3_policy_name" {
  type    = string
}

variable "s3_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
}

variable "s3_to_ec2_role_tags" {
  description = "A map of tags to add to all ec2 iam role"
  type        = map(string)
}

# keys
variable "key_file" {
  description = "project key file name"
  type        = string
}

variable "key_name" {
  description = "project key pair name"
  type        = string
}

# Tags for all
variable "tags" {
  description = "Additional tags for all the resources"
  type        = map(string)
}

# k8s
variable "kubernetes_version" {
  description = "kubernetes version"
}

variable "kubectl_version" {
  type    = string
  description = "kubectl version"
}

# consul
variable "consul_servers_count" {
  description = "Number of consul servers to create"
  type        = number 
}

variable "consul_instance_type" {
  description = "consul servers instance type"
  type        = string
}


variable "port_8500_ips" {
  description = "list of ips allowed to access consul ui on port 8500"
  type        = list(string)
}


variable "consul_asg_enabled_metrics" {
  description = "Auto scaling group enabled metrics"
  type        = list(string)
}

# Jenkins
variable "port_80_ips" {
  description = "list of ips allowed to access jenkins master on port 80"
  type        = list(string)
}

variable "jenkins_agent_count" {
  description = "Number of jenkins agents to create"
  type        = number 
}

variable "jenkins_ec2_policy_name" {
  description = "Jenkins ec2 policy name"
  type        = string
}

variable "jenkins_ec2_role_name" {
  description = "Jenkins role"
  type        = string 
}

# bastion
variable "bastion_inbound_allowed_ips" {
  description = "List of allowed cidr(s) to ssh to the bastion host"
  type        = list(string) 
}

# ansible
variable "ansible_ami" {
  description = "Ansible AMI"
  type        = string
}

variable "ansible_instance" {
  description = "instance type"
  type        = string
}

variable "ansible_count" {
  description = "Number of ansible instances"
  type        = number
}

variable "ansible_ec2_role_name" {
  description = "ansible ec2 role name"
  type        = string
}

variable "ansible_ec2_policy_name" {
  description = "ansible ec2 policy name"
  type        = string
}

variable "ansible_folder" {
  description = "ansible folder path which contains the roles, playbooks etc"
  type        = string
}

# monitoring - grafana
variable "port_3000_ips" {
  description = "list of ips allowed to access grafana ALB"
  type        = list(string)
}

# logging - kibana
variable "port_5601_ips" {
  description = "list of ips allowed to access kibana ALB"
  type        = list(string)
}



##################################################################################
# LOCALS
##################################################################################

locals {

  # Jenkins
  jenkins_default_name = "jenkins"
  jenkins_home = "/home/ubuntu/jenkins_home"
  jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
  docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
  java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"

  # eks
  k8s_service_account_namespace = "default"
  k8s_service_account_name      = "opsschool-sa"
  cluster_name = "project-eks"

}