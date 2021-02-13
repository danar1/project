resource "aws_lb" "jenkins" {
  name                       = "jenkins-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.public_subnets
  security_groups            = [aws_security_group.jenkins-lb-sg.id]

  tags = merge(var.tags, map("Name", "jenkins-alb"))
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
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }

  tags = merge(var.tags, map("Name", "jenkins-target-group"))
}

resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = aws_lb_target_group.jenkins.id
  target_id        = aws_instance.jenkins_master.id
  port             = 8080
}