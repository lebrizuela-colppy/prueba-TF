resource "aws_route_table" "main" {
    for_each     = { for t in local.json_routetables : t.tags.Name => t }
    vpc_id = aws_vpc.main[each.value.vpc_id].id

    dynamic route {
      for_each = {for n in each.value.routes : n.id => n}
      
      content {
        cidr_block = route.value.cidr_block
        gateway_id = try(aws_internet_gateway.main[route.value.gateway_id].id,"")
        transit_gateway_id = try(route.value.transit_gateway_id, null)
        nat_gateway_id = try(aws_nat_gateway.main[route.value.nat_gateway].id,"")
      }
    }

    tags = {
      Name = each.value.tags.Name
    }
}

resource "aws_route_table_association" "main" {
  for_each     = { for t in local.json_routetablesassocs : t.id => t }
  subnet_id      = aws_subnet.main[each.value.subnet_name].id
  route_table_id = aws_route_table.main[each.value.rt_name].id
}
