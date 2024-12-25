module "bucket_reports_transactions" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-s3.git?ref=1.5.0"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  object_lock_enabled_status      = local.object_lock_enabled_status
  versioning_configuration_status = local.versioning_configuration_status
  retention_mode                  = local.retention_mode
  retention_time                  = local.retention_time
  bucket_name                     = "${var.env}-${var.project}-files-s3"
  kms_key_id                      = var.s3_kms_key_id
  s3_bucket_acl                   = local.s3_bucket_acl
  block_public_acls               = local.block_public_acls
  block_public_policy             = local.block_public_policy
  ignore_public_acls              = local.ignore_public_acls
  restrict_public_buckets         = local.restrict_public_buckets
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-files-s3"
      PCI : "No"
      Impact : "Bajo"
    },
  )
}