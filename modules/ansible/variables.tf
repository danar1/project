variable "ami" {
  description = "Ansible AMI"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

variable "ansible_count" {
  description = "Number of ansible instances"
  type        = number
}

variable "instance_type" {
  description = "instance type"
  type        = string
}

# Tags for all
variable "tags" {
  description = "Additional tags for all the resources"
  type        = map(string)
}

variable "subnet_ids" {
  description = "subnets ids"
  type        = list(string)
}

variable "key_name" {
  description = "key name"
  type        = string
}

variable "key_file" {
  description = "key file name"
  type        = string
}

variable "bastion_public_ips" {
  description = "list of bastion server public ips"
  type        = list(string)
}

# variable "ansible-sg" {
#   description = "ansible security group"
#   type        = list(string)
# }

variable "ssh_security_group_ids" {
  description = "list of security group ids, for ansible security ingress"
  type        = list(string)
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
















