variable "region" {
  description = "AWS region for VMs"
  type        = string
}


variable "ubuntu_ami_owner" {
  description = "Ubuntu AMI owner"
  type        = string 
}

variable "ansible_server_ami" {
  description = "Ubuntu AMI owner"
  type        = string 
}


variable "consul_servers_count" {
  description = "Number of consul servers to create"
  type        = number 
}

variable "consul_agent_count" {
  description = "Number of consul agents to create"
  type        = number
}


variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

variable "subnet_id" {
  description = "Ansible Subnet id"
  type        = string
}

variable "ingress_ports" {
  description = "list of ingress ports"
  type        = list(number)
}

# variable "port_22_security_groups" {
#   description = "list of security groups to allow ssh access"
#   type        = list(string)
# }

variable "key_file" {
  description = "project key file name"
  type        = string
}

variable "key_name" {
  description = "project key pair name"
  type        = string
}

