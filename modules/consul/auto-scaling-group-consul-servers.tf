##################################################################################
# launch template
##################################################################################
resource "aws_launch_template" "consul-launch-template" {
  name_prefix   = "consul-"
  image_id      = data.aws_ami.ubuntu1804.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.consul-launch-template-sg.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.consul-instance-profile.name
  }
  monitoring {
    enabled = true
  }

  tags = merge(var.tags, map("Name", "consul-launch-template"))

  tag_specifications {
    resource_type = "instance"

    tags = merge(var.tags, {"Name" = "consul-server", "consul_server" = "true"})
  }
}

##################################################################################
# Auto scaling group
##################################################################################
resource "aws_autoscaling_group" "consul-asg" {
  desired_capacity    = var.consul_servers_count
  max_size            = var.consul_servers_count
  min_size            = var.consul_servers_count
  vpc_zone_identifier = var.subnet_ids
  enabled_metrics     = var.enabled_metrics

  launch_template {
    id      = aws_launch_template.consul-launch-template.id
    version = "$Latest"
  }
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tags = [{"key" = "Name", "value" = "consul-asg", "propagate_at_launch" = false}]
  
  
}

##################################################################################
# ALB Target Group attachment
##################################################################################
resource "aws_autoscaling_attachment" "consul-asg-alb-target-group-attachment" {
  autoscaling_group_name = aws_autoscaling_group.consul-asg.id
  alb_target_group_arn   = aws_lb_target_group.consul-alb-target-group.arn
}