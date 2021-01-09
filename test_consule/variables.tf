variable "aws_region" {
  description = "AWS region for VMs"
  default = "us-east-1"
}


variable "ubuntu_ami_owner" {
  description = "Ubuntu AMI owner"
  default = "099720109477"
}

variable "project_ubuntu_ami" {
  description = "Project Ubuntu AMI owner"
  default = "ami-083547ef8b8f5b0bc"
}


variable "consul_servers_count" {
  description = "Number of consul servers to create"
  default = 3
}

variable "consul_agent_count" {
  description = "Number of consul agents to create"
  default = 1
}


variable "vpc_id" {
  description = "AWS VPC id"
  default     = "vpc-a0d417dd"
}

variable "subnet_id" {
  description = "Ansible Subnet id"
  default     = "subnet-403c8c1f"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22]
}

# variable "port_22_security_groups" {
#   description = "list of security groups to allow ssh access"
#   type        = list(string)
#   default     = 
# }

variable "key_file" {
  description = "project key file name"
  type        = string
  default     = "project_key"
}


