resource "aws_nat_gateway" "main" {
  for_each      = { for t in local.json_nats : t.tags.Name => t }
  allocation_id = aws_eip.main[each.value.allocation].id
  subnet_id     = aws_subnet.main[each.value.subnet].id

  tags = {
    Name = each.value.tags.Name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}
