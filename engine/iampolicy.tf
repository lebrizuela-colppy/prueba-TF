resource "aws_iam_policy" "main" {
  for_each    = { for t in local.json_policies : t.tags.Name => t }
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = file(each.value.raw_document)
}