resource "aws_lb" "main" {
  for_each     = { for t in local.json_loadbalancer : t.tags.Name => t }
  name               = each.value.name
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups    = [ for sgn in each.value.security_groups : aws_security_group.main[sgn].id ]
  subnets            = [ for subnet in each.value.subnets : aws_subnet.main[subnet].id ]

  enable_deletion_protection = false

  tags = {
    Name = each.value.tags.Name
  }
}

resource "aws_lb_listener" "main" {
  for_each          = { for t in local.json_loadbalancer : t.tags.Name => t }
  load_balancer_arn = aws_lb.main[each.value.tags.Name].arn
  port              = each.value.forward.listening_port
  protocol          = each.value.forward.listening_protocol
  ssl_policy        = each.value.forward.ssl_policy
  certificate_arn   = aws_acm_certificate.main[each.value.forward.certificate_arn_name].arn

  default_action {
    type             = each.value.forward.action_type
    target_group_arn = aws_lb_target_group.main[each.value.forward.target_group_name].arn
  }
}

resource "aws_lb_listener" "redirect" {
  for_each          = { for t in local.json_loadbalancer : t.tags.Name => t }
  load_balancer_arn = aws_lb.main[each.value.tags.Name].arn
  port              = each.value.redirect.listening_port
  protocol          = each.value.redirect.listening_protocol

  default_action {
    type = each.value.redirect.action_type

    redirect {
      port        = each.value.redirect.redirect_port
      protocol    = each.value.redirect.redirect_protocol
      status_code = each.value.redirect.status_code
    }
  }
}