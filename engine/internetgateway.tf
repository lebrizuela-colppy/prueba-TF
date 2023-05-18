resource "aws_internet_gateway" "main" {
    for_each     = { for t in local.json_internetgateways : t.tags.Name => t }
    vpc_id     = aws_vpc.main[each.value.vpc_id].id

    tags = {
        Name = each.value.tags.Name
    }
}