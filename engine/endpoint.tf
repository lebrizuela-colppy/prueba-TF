resource "aws_vpc_endpoint" "main" {
  for_each     = { for t in local.json_endpoints : t.tags.Name => t }
  vpc_id       = aws_vpc.main[each.value.vpc_id].id
  service_name = each.value.service_name
  vpc_endpoint_type = each.value.vpc_endpoint_type
  private_dns_enabled = each.value.private_dns_enabled
  subnet_ids = try([aws_subnet.main[each.value.subnet_ids[0]].id],[])

  tags = {
    Name        = each.value.tags.Name
  }
}
