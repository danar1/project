##################################################################################
# Security Groups
##################################################################################
resource "aws_security_group" "jenkins-master-sg" {
  name = "jenkins-master-sg"
  vpc_id = var.vpc_id
  description = "Allow Jenkins master inbound traffic"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.jenkins-lb-sg.id]
  }

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
  
  tags = merge(var.tags, map("Name", "jenkins-master-sg"))
}

resource "aws_security_group" "jenkins-agent-sg" {
  name = "jenkins-agent-sg"
  vpc_id = var.vpc_id
  description = "Allow Jenkins agent inbound traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = concat([aws_security_group.jenkins-master-sg.id], var.ssh_security_group_ids)
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
  
  tags = {
    Name = "jenkins-agent-sg"
  }
}

resource "aws_security_group" "jenkins-lb-sg" {
  name = "jenkins-lb-sg"
  vpc_id = var.vpc_id
  description = "Allow Jenkins inbound traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.port_80_ips # ["0.0.0.0/0"]
  }

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
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  
  tags = merge(var.tags, map("Name", "jenkins-lb-sg"))
}

