resource "aws_iam_user" "main" {
  for_each      = { for t in local.json_users : t.tags.Name => t }
  name          = each.value.name
  path          = each.value.path
  # This flag allow us destroy all when iam access key was generated whitout terraform
  force_destroy = true
  tags = {
    Name        = each.value.tags.Name
  }
}

resource "aws_iam_user_policy_attachment" "main" {
  for_each      = { for t in local.json_users : t.tags.Name => t }
  user          = aws_iam_user.main[each.value.tags.Name].name
  policy_arn    = aws_iam_policy.main[each.value.policy_name].arn
}