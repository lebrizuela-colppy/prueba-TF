resource "aws_instance" "main" {
  for_each      = { for t in local.json_ec2s : t.tags.Name => t }
  ami           = each.value.ami
  instance_type = each.value.instance_type
  iam_instance_profile = each.value.iam_instance_profile
  # vpc_security_group_ids = each.value.security_groups
  key_name = each.value.key_name

  network_interface {
    network_interface_id = aws_network_interface.main[each.value.nic].id
    device_index         = 0
  }

  tags = {
    Name = each.value.tags.Name
  }

}
