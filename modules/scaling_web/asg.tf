resource "aws_autoscaling_group" "web_asg" {
  name                = "${local.name_prefix}-web-asg"
  min_size            = 2
  max_size            = 3
  desired_capacity    = 3
  vpc_zone_identifier = var.private_subnet_ids # Private subnets

  launch_template {
    id      = aws_launch_template.web_server_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_alb_tg.arn]  # Auto-Register Instances
  
  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-web_app"
    propagate_at_launch = true  # This propagates the tag to instances launched by the ASG
  }
}