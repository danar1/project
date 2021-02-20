##################################################################################
# Consul ALB
##################################################################################
resource "aws_lb" "consul-lb" {
  name                       = "consul-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.subnet_ids
  security_groups            = [aws_security_group.consul-lb-sg.id]

  tags = merge(var.tags, map("Name", "consul-alb"))
}


resource "aws_lb_listener" "consul-lb-listener" {
  load_balancer_arn = aws_lb.consul-lb.arn
  port              = 8500
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.consul-alb-target-group.arn
  }
}

resource "aws_lb_target_group" "consul-alb-target-group" {
  name     = "consul-target-group"
  port     = 8500
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    port                = 8500
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 5
    matcher             = 301   # todo- understand why response code is 301 and not 200

  }

  tags = merge(var.tags, map("Name", "consul-alb-target-group"))
}



