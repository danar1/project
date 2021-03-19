##################################################################################
# Security Groups
##################################################################################

# Security Group for elasticsearch
resource "aws_security_group" "logging_elasticsearch" {
  name        = "logging_elasticsearch"
  description = "Security group for elasticsearch server"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = var.ssh_security_group_ids
  }

  # Allow traffic to HTTP port 9200 [Elasticsearch REST interface]
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "TCP"
    security_groups = [aws_security_group.logging_kibana.id]
  }
}

# Security Group for kibana
resource "aws_security_group" "logging_kibana" {
  name        = "logging_kibana"
  description = "Security group for kibana server"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = var.ssh_security_group_ids
  }

  # Allow traffic to HTTP port 3000 from ALB [Kibana Web Interface]
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "TCP"
    security_groups = [aws_security_group.kibana-lb-sg.id]
  }

}

resource "aws_security_group" "kibana-lb-sg" {
  name = "kibana-lb-sg"
  vpc_id = var.vpc_id
  description = "Allow kibana inbound traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.port_5601_ips
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
  
  tags = merge(var.tags, map("Name", "kibana-lb-sg"))
}