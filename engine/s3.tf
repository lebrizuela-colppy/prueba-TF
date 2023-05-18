resource "aws_s3_bucket" "main" {
    for_each     = { for t in local.json_s3 : t.tags.Name => t }
    bucket       = each.value.tags.Name

    tags = {
      Name       = each.value.tags.Name
    }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  for_each      = { for t in local.json_s3 : t.tags.Name => t if t.encryption_enabled == true }
  bucket        = each.value.tags.Name

  rule {
    apply_server_side_encryption_by_default {
      ## If kms_master_key_id is null the bucket encrypt will be SSE-KMS and use the default key aws/s3
      kms_master_key_id = try(aws_kms_key.main[each.value.encryption_kms_key_name].arn, null)  
      sse_algorithm     = each.value.encryption_algorithm
    }
  }
}