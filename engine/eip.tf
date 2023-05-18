resource "aws_eip" "main" {
  for_each = { for t in local.json_eips : t.tags.Name => t }
  tags = {
    Name = each.value.tags.Name
  }
}
