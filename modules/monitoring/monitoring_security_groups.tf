##################################################################################
# Security Groups
##################################################################################

# Security Group for prometheus
resource "aws_security_group" "monitor_prometheus" {
  name        = "monitor_prometheus"
  description = "Security group for prometheus server"
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

  # Allow traffic to HTTP port 9090 from grafana
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "TCP"
    security_groups = [aws_security_group.monitor_grafana.id]
  }
}

# Security Group for grafana
resource "aws_security_group" "monitor_grafana" {
  name        = "monitor_grafana"
  description = "Security group for grafana server"
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

  # Allow traffic to HTTP port 3000 from ALB
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    security_groups = [aws_security_group.grafana-lb-sg.id]
  }

}

resource "aws_security_group" "grafana-lb-sg" {
  name = "grafana-lb-sg"
  vpc_id = var.vpc_id
  description = "Allow grafana inbound traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.port_3000_ips
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
  
  tags = merge(var.tags, map("Name", "grafana-lb-sg"))
}