resource "aws_vpc" "main" {
  for_each     = { for t in local.json_vpc : t.tags.Name => t }
  cidr_block = each.value.cidr_block
  enable_dns_support = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
    tags = {
        Name = each.value.tags.Name
    }
}


resource "aws_main_route_table_association" "default" {
  vpc_id         = aws_vpc.main["customer-data-prod-svc-vpc"].id
  route_table_id = aws_vpc.main["customer-data-prod-svc-vpc"].default_route_table_id
}