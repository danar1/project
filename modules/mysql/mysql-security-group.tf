##################################################################################
# Security Groups
##################################################################################
resource "aws_security_group" "mysql-sg" {
  name = "mysql-sg"
  vpc_id = var.vpc_id
  description = "Allow mysql inbound traffic"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = var.port_3306_ips
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(var.tags, map("Name", "mysql-sg"))
}

