
resource "aws_db_subnet_group" "main" {
  for_each   = local.json_dbsubnet
  name       = each.value.name
  subnet_ids = [aws_subnet.main[each.value.subnets[0]].id, aws_subnet.main[each.value.subnets[1]].id]

  tags = each.value.tags
}
