resource "aws_subnet" "main" {
    for_each = {for t in local.json_subnets : t.tags.Name => t}
    vpc_id     = aws_vpc.main[each.value.vpc_id].id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone

    tags = {
        Name = each.value.tags.Name
    }
}