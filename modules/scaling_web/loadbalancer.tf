
resource "aws_lb" "web_alb" {
  
  name               = "${local.name_prefix}-webapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids
  
  tags = {
    Name = "${local.name_prefix}-webapp-lb"
  }
}

resource "aws_lb_target_group" "web_alb_tg" {
  name     = "${local.name_prefix}-webapp-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id  # Pass VPC ID from network module
  target_type = "instance"

  health_check {
    path     = "/index.html"
    port     = 80
    protocol = "HTTP"
    timeout  = 3
    interval = 5
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

/*
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
  */
    default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }
}

resource "aws_lb_listener_rule" "web_app" {             
  #This rule is optional, but used for conditional forwarding
  # to the target group based on the path pattern.
  # count        = aws_lb.web_alb.arn != "" ? 1 : 0
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/${local.name_prefix}"]
    }
  }
}


/*
resource "aws_lb_target_group_attachment" "get_webapps" {
  # covert a list of instance objects to a map with instance ID as the key, and an instance
  # object as the value.
  for_each = {
    for k, v in aws_instance.example :
    k => v
  }

  target_group_arn = aws_lb_target_group.example.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_app" {
  count            = var.alb_listener_arn != "" ? length(aws_instance.web_app) : 0
  target_group_arn = aws_lb_target_group.web_app[0].arn
  target_id        = aws_instance.web_app[count.index].id
  port             = 80
}

resource "aws_lb_listener_rule" "web_app" {
  count        = var.alb_listener_arn != "" ? 1 : 0
  listener_arn = var.alb_listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_app[0].arn
  }

  condition {
    path_pattern {
      values = ["/${local.name_prefix}"]
    }
  }
}

*/