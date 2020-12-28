##################################################################################
# VARIABLES 
##################################################################################

# vpc modules var
variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default = {
    Name   = "project-vpc"
  }

}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnet"
  type        = map(string)
  default = {
    Name   = "public-subnet"
  }
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnet"
  type        = map(string)
  default = {
    Name   = "private-subnet"
  }
}

variable "gw_tags" {
  description = "Additional tags for the GW"
  type        = map(string)
  default = {
    Name   = "igw"
  }
}

variable "eip_tags" {
  description = "Additional tags for the S3 EIP"
  type        = map(string)
  default = {
    Name   = "eip"
  }
}

variable "nat_tags" {
  description = "Additional tags for the NAT"
  type        = map(string)
  default = {
    Name   = "nat-gw"
  }
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route table"
  type        = map(string)
  default = {
    Name   = "public-rt"
  }
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route table"
  type        = map(string)
  default = {
    Name   = "private-rt"
  }
}

# ec2 module tags
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "sg_web_tags" {
  description = "Additional tags for web security group"
  type        = map(string)
  default     = {}
}

variable "sg_db_tags" {
  description = "Additional tags for db security group"
  type        = map(string)
  default     = {}
}

variable "sg_alb_tags" {
  description = "Additional tags for ALB security group"
  type        = map(string)
  default     = {}
}

variable "web_tags" {
  description = "Additional tags for web instances"
  type        = map(string)
  default     = {}
}

variable "db_tags" {
  description = "Additional tags for db instances"
  type        = map(string)
  default     = {}
}

variable "alb_tags" {
  description = "Additional tags for ALB"
  type        = map(string)
  default     = {}
}

variable "tg_tags" {
  description = "Additional tags for target group"
  type        = map(string)
  default     = {}
}

variable "health_check" {
  type    = map(any)
  default = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = 80
        protocol            = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
  }
}

variable "stickiness_cookie_duration" {
  description = "stickiness cookie duration in seconds"
  type        = number
  default     = 60
}

# s3 module vars
variable "bucket" {
  type    = string
  default = "ops-dana-bucket"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "role_name" {
  type    = string
  default = "ops-ec2-iam-role"
}

variable "s3_policy_name" {
  type    = string
  default = "ops-s3-policy"
}

variable "s3_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "ec2_iam_role_tags" {
  description = "A map of tags to add to all ec2 iam role"
  type        = map(string)
  default     = {}
}

variable "key_file" {
  description = "project key file name"
  type        = string
  default     = "project_key"
}

variable "jenkins_agent_count" {
  description = "The amount of jenkins agents"
  type        = number
  default     = 2
}




##################################################################################
# LOCALS
##################################################################################

locals {
  common_tags = {
    Purpose   = "project"
    Owner     = "dana"
  }

  jenkins_default_name = "jenkins"
  jenkins_home = "/home/ubuntu/jenkins_home"
  jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
  docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
  java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"

}