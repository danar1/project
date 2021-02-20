##################################################################################
# Security Groups
##################################################################################
resource "aws_security_group" "ansible-sg" {
  name = "ansible-sg"
  vpc_id = var.vpc_id
  description = "Allow ansible inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = var.ssh_security_group_ids
  }

  egress {
    description = "Allow all outgoing traffic"
    from_port = 0
    to_port = 0
    // -1 means all
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(var.tags, map("Name", "ansible-sg"))
}

