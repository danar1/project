resource "aws_lb" "jenkins" {
  name                       = "jenkins-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = module.vpc.public_subnets
  security_groups            = [aws_security_group.jenkins-lb-sg.id]

  tags = merge(local.common_tags, map("Name", "jenkins-alb"))
}


resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}

resource "aws_lb_target_group" "jenkins" {
  name     = "jenkins-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = module.vpc.id

  health_check {
    enabled = true
    path    = "/"
  }

  tags = merge(local.common_tags, map("Name", "jenkins-target-group"))
}

# Dana below instead
# resource "aws_lb_target_group_attachment" "jenkins" {
#   count            = length(aws_instance.nginx)
#   target_group_arn = aws_lb_target_group.jenkins.id
#   target_id        = var.public_subnet[count.index]
#   port             = 80
# }

resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = aws_lb_target_group.jenkins.id
  target_id        = aws_instance.jenkins_server.id
  port             = 8080
}

resource "aws_security_group" "jenkins-lb-sg" {
  name = "jenkins-lb-sg"
  vpc_id = module.vpc.id
  description = "Allow Jenkins inbound traffic"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.bastion-ssh.id]
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
  
  tags = merge(local.common_tags, map("Name", "enkins-lb-sg"))
}