resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  for_each      = { for t in local.json_transit_gateway_attachment : t.tags.Name => t }
  transit_gateway_id = each.value.transit_gateway_id
  vpc_id             = aws_vpc.main[each.value.vpn_name].id

  subnet_ids = [for name in each.value.subnet_name : aws_subnet.main[name].id]

    tags = {
        Name = each.value.tags.Name
    }
}
