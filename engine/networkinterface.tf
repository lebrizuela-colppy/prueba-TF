resource "aws_network_interface" "main" {
    for_each      = { for t in local.json_networkinterfaces : t.tags.Name => t }
    subnet_id       = aws_subnet.main[each.value.subnet].id
    security_groups = [aws_security_group.main[each.value.security_groups[0]].id]
    tags = {
        Name = each.value.tags.Name
    }
}