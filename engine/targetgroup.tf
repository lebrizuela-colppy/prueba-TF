resource "aws_lb_target_group" "main" {
  for_each      = { for t in local.json_targetgroups : t.tags.Name => t }
  name          = each.value.name
  port          = each.value.port
  protocol      = each.value.protocol
  vpc_id        = aws_vpc.main[each.value.vpc_id].id
}

resource "aws_lb_target_group_attachment" "main" {
  for_each          = { for t in local.json_targetgroups : t.tags.Name => t }
  target_group_arn  = aws_lb_target_group.main[each.value.tags.Name].arn
  target_id         = aws_instance.main[each.value.instance_name].id
  port              = each.value.port
}