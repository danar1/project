variable "ami" {
  description = "mysql AMI"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

variable "mysql_count" {
  description = "Number of mysql instances"
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

# variable "bastion_public_ips" {
#   description = "list of bastion server public ips"
#   type        = list(string)
# }


# variable "ssh_security_group_ids" {
#   description = "list of security group ids, for mysql security ingress"
#   type        = list(string)
# }


variable "port_3306_ips" {
  description = "list of ips allowed to access mysql"
  type        = list(string)
}















