variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

# variable "private_subnets" {
#   description = "list of private subnet ids"
#   type        = list(string)
# }

variable "subnet_ids" {
  description = "list of public subnet ids"
  type        = list(string)
}

variable "tags" {
  description = "Additional tags for all the resources"
  type        = map(string)
}

variable "key_name" {
  description = "project key pair name"
  type        = string
}

variable "key_file" {
  description = "key file name"
  type        = string
}

variable "ssh_security_group_ids" {
  description = "list of security group ids"
  type        = list(string)
}

variable "nat_gw_id" {
  description = "The NAT gw id, the prometheus and grafana depends on"
  type        = string
}

variable "port_3000_ips" {
  description = "list of ips allowed to access grafana ALB"
  type        = list(string)
}

variable "bastion_public_ips" {
  description = "list of bastion server public ips"
  type        = list(string)
}

variable "consul-security-group" {
  description = "consul security group id"
  type        = string
}

variable "consul-role" {
  description = "consul role name"
  type        = string
}