resource "aws_kms_key" "main" {
    for_each                    = { for t in local.json_kms_keys : t.tags.Name => t }
    
    description                 = each.value.description
    is_enabled                  = each.value.is_enabled
    customer_master_key_spec    = each.value.customer_master_key_spec
    policy                      = file(each.value.policy_json_document)
    multi_region                = each.value.multi_region
    key_usage                   = each.value.key_usage
    
    tags = {
      Name       = each.value.tags.Name
    }
}