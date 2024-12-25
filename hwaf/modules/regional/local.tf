locals {
  tags = {
    "Project" : "hwaf",
    "ENV" : "${var.env}",
    "Servicio_NBZ" : "hwaf",
    "Gerencia" : "SSN",
    "Ambiente" : "${var.env}",
    "PCI" : "No",
    "Vigencia" : "Indefinida",
  }

  envproject = var.env == "prd" ? var.project : "${var.env}-${var.project}"

#################################################################
#           NLB
#################################################################
  ec2_ids_list = [
    module.instance_ec2_hwaf.id
  ]
#################################################################
#           RDS
#################################################################
  iam_database_authentication_enabled = true
  engine                              = "mysql"
  engine_version                      = "8.0.32"
  parameterg_family_mysql             = "mysql8.0"
  availability_zone                   = "us-east-1a"
  allocated_storage                   = 20
  storage_type                        = "gp2"
  multi_az                            = false
  monitoring_interval                 = "10"
  storage_encrypted                   = true
  skip_final_snapshot                 = false
  apply_immediately                   = true
  create_monitoring_role              = true
  enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]
  iam_role_use_name_prefix            = false
  iam_role_description                = "IAM Role used for RDS Enhanced Monitoring."

  #S3
  bucket_name                     = "frontend"
  object_lock_enabled_status      = false
  versioning_configuration_status = "Enabled"
  retention_mode                  = "GOVERNANCE"
  retention_time                  = 365
  enable_s3_policy_cloudfront     = true
  bucket_encrypt_with_kms_enabled = false
  bucket_sse_algorithm            = "AES256"
  s3_bucket_acl                   = "private"
  block_public_acls               = true
  block_public_policy             = true
  ignore_public_acls              = true
  restrict_public_buckets         = true
}