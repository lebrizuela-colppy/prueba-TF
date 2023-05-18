variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    tags        = map(string)
  }))
}

resource "aws_security_group" "main" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description

  ingress {
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }

  tags = each.value.tags
}
