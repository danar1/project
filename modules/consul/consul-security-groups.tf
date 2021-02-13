##################################################################################
# launch template security group
##################################################################################
resource "aws_security_group" "consul-launch-template-sg" {
  name        = "consul-servers-sg"
  vpc_id      = var.vpc_id
  description = "Allow ssh & consul inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = var.ssh_security_group_ids
    description = "Allow ssh from the specifies security groups"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    security_groups = [aws_security_group.consul-lb-sg.id]
    description = "Allow consul UI access from the consul ALB"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow all outside security group"
  }

  tags = merge(var.tags, map("Name", "consul-servers-sg"))
}

##################################################################################
# consul ALB security group
##################################################################################
resource "aws_security_group" "consul-lb-sg" {
  name = "consul-lb-sg"
  vpc_id = var.vpc_id
  description = "Allow consul ALB inbound traffic"

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = var.port_8500_ips
    description = "Allow consul UI access from the specified ips"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = var.ssh_security_group_ids
    description = "Allow ssh from the specifies security groups"
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  
  tags = merge(var.tags, map("Name", "consul-lb-sg"))
}
