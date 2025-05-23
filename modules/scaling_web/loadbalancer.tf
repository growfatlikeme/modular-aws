/*
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

  default_action {
      type = "redirect"
      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
}

# HTTPS listener to your ALB
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

  depends_on = [aws_acm_certificate_validation.cert]
}

resource "aws_lb_listener_rule" "web_app" {             
  #This rule is optional, but used for conditional forwarding
  # to the target group based on the path pattern.
  # count        = aws_lb.web_alb.arn != "" ? 1 : 0
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 50

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg.arn
  }

  condition {
    path_pattern {
      values = ["/index.html"]
    }
  }
}

resource "aws_lb_listener_rule" "web_app_2" {             
  #This rule is optional, but used for conditional forwarding
  # to the target group based on the path pattern.
  # count        = aws_lb.web_alb.arn != "" ? 1 : 0
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 45

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      status_code  = "404"
      message_body = "<h1>File not found</h1>"
    }
    }

    condition {
      path_pattern {
        values = ["/*"]  # Matches all requests
      }
    }

  }

resource "aws_lb_listener_rule" "forbidden_rule" {
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 20  # Higher priority than default action

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      status_code  = "403"
      message_body = "<h1>403 Forbidden: You are not allowed to access this page.</h1>"
    }
  }

  condition {
    path_pattern {
      values = ["/admin/*"]  # Blocks access to /admin routes
    }
  }
}

resource "aws_lb_listener_rule" "server_error_rule" {
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 10  # Higher priority than default action

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      status_code  = "500"
      message_body = "<h1>500 Internal Server Error: Something went wrong.</h1>"
    }
  }

  condition {
    http_request_method {
      values = ["POST"]  # Apply to requests that use POST
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