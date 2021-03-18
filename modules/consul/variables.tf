variable "consul_servers_count" {
  description = "Number of consul servers to create"
  type        = number 
}

variable "instance_type" {
  description = "consul servers instance type"
  type        = string
}

variable "subnet_ids" {
  description = "list of public subnet ids"
  type        = list(string)
}

variable "key_name" {
  description = "project key pair name"
  type        = string
}

variable "ssh_security_group_ids" {
  description = "list of security group ids"
  type        = list(string)
}

variable "port_8500_ips" {
  description = "list of ips allowed to access consul ui on port 8500"
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

variable "enabled_metrics" {
  description = "Auto scaling group enabled metrics"
  type        = list(string)
}











