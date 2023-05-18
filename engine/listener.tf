resource "aws_lb_listener_rule" "main" {
  for_each     = { for t in local.json_listeners : t.tags.Name => t }
  listener_arn = aws_lb_listener.main[each.value.listener_arn].arn
  priority     = each.value.priority

  action {
    type              = each.value.action_type
    target_group_arn  = aws_lb_target_group.main[each.value.target_group_name].arn
  }

  condition {
    host_header {
      values = [ each.value.host_header_condition ]
    }
  }

  tags = {
    Name = each.value.tags.Name
  }
}
