resource "aws_acm_certificate" "main" {
  for_each                    = { for t in local.json_acm : t.tags.Name => t }
  domain_name                 = each.value.domain_name
  validation_method           = each.value.validation_method
  subject_alternative_names   = each.value.subject_alternative_names
  tags = {
    Name = each.value.tags.Name
  }
}