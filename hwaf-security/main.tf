module "ec2_kms" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-kms.git?ref=1.1.1"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  alias                         = "${var.env}-${var.project}-${var.kms_ec2_alias}"
  description                   = var.kms_ec2_description
  principal_role_name           = var.kms_ec2_principal_role_name
  enabled                       = var.kms_ec2_enabled_replica
  create_pipeline_policy        = var.kms_ec2_create_pipeline_policy
  create_admin_principal_policy = var.kms_ec2_create_admin_principal_policy
  pipeline_role_name            = var.pipeline_role_name
  primary_region                = var.primary_region
  tags = merge(
    local.tags,
    {
      Name = "${var.env}-${var.project}-${var.kms_ec2_alias}"
      PCI = "NO"
      Impact = "Alto"
    },
  )
}

module "ec2_role" {
  source                  = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-iam-roles-policies.git?ref=1.17.0"
  enable_ec2_role         = true
  ec2_role_name           = "${var.env}-${var.project}-ec2"
  ec2_statement_policy    = [] 
  ec2_managed_policies    = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
  ec2_instance_role_name     = "${var.env}-${var.project}-ec2-role"
  ec2_role_tags = merge(
    local.tags,
    {
      Name   = "${var.env}-${var.project}-ec2-role"
      PCI    = "NO"
      Impact = "Medio"
    }
  )
}

module "ec2_sg" {
  source      = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-security-group.git?ref=1.0.3"
  create_sg   = true
  description = "Security Group used by EC2."
  name        = "${var.env}-${var.project}-ec2-sg"
  vpc_id      = var.vpc_id
  tags = merge(
    local.tags,
    {
      Name = "${var.env}-${var.project}-ec2-sg"
      Impact = "Alto"
    },
  )
  security_group_rules      = var.security_group_rules
  source_security_group_id  = var.source_security_group_id
}

module "nlb_sg" {
  source      = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-security-group.git?ref=1.0.3"
  create_sg   = true
  description = "Security Group used by NLB."
  name        = "${var.env}-${var.project}-nlb-sg"
  vpc_id      = var.nlb_vpc_id
  tags = merge(
    local.tags,
    {
      Name = "${var.env}-${var.project}-nlb-sg"
      Impact = "Alto"
    },
  )
  security_group_rules      = var.nlb_security_group_rules
  source_security_group_id  = var.nlb_source_security_group_id
}
module "kms_vtst_origin" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-kms.git?ref=1.1.3"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  alias               = "${var.env}-${var.project}-${var.kms_frontend_origin_alias}"
  description         = var.kms_frontend_origin_description
  pipeline_role_name  = var.pipeline_role_name
  principal_role_name = var.kms_frontend_origin_principal_role_name

  create_s3_service_policy      = var.kms_frontend_origin_create_s3_service_policy
  create_pipeline_policy        = var.kms_frontend_origin_create_pipeline_policy
  create_admin_principal_policy = var.kms_frontend_origin_create_admin_principal_policy

  primary_region = var.primary_region

  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.kms_frontend_origin_alias}"
      PCI : "NO"
      Impact : "Alto"
    },
  )
}

module "kms_secrets_manager_rds" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-kms.git?ref=1.2.1"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  alias                                = "${var.env}-${var.project}-${var.kms_secrets_manager_rds_alias}"
  description                          = var.kms_secrets_manager_rds_description
  create_secretsmanager_service_policy = var.kms_create_secretsmanager_rds_service_policy
  create_pipeline_policy               = var.kms_secrets_manager_rds_create_pipeline_policy
  create_admin_principal_policy        = var.kms_secrets_manager_rds_create_admin_principal_policy
  principal_role_name                  = var.kms_secrets_manager_rds_principal_role_name
  pipeline_role_name                   = var.pipeline_role_name
  primary_region                       = var.primary_region
  secondary_region                     = var.secondary_region
  multi_region                         = var.kms_secrets_manager_rds_multiregion
  enabled                              = var.kms_secrets_manager_rds_enabled
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.kms_secrets_manager_rds_alias}"
      PCI : "No"
      Impact : "Alto"
    },
  )
}

module "secrets_manager_rds" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-secrets-manager.git?ref=1.1.0"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  create_random_password            = var.secrets_manager_rds_create_random_password
  random_password_length            = var.secrets_manager_rds_random_password_length
  random_password_lower             = var.secrets_manager_rds_random_password_lower
  random_password_min_lower         = var.secrets_manager_rds_random_password_min_lower
  random_password_number            = var.secrets_manager_rds_random_password_number
  random_password_min_numeric       = var.secrets_manager_rds_random_password_min_numeric
  random_password_special           = var.secrets_manager_rds_random_password_special
  random_password_min_special       = var.secrets_manager_rds_random_password_min_special
  random_password_upper             = var.secrets_manager_rds_random_password_upper
  random_password_min_upper         = var.secrets_manager_rds_random_password_min_upper
  random_password_override_special  = var.secrets_manager_rds_random_password_override_special
  description                       = var.secrets_manager_rds_description
  kms_key_id                        = module.kms_secrets_manager_rds.kms_arn
  name                              = "${var.env}-${var.project}-${var.secrets_manager_rds_name}"
  principal_role_name               = "${var.env}-${var.project}-${var.secrets_manager_rds_principal_role_name}"
  pipeline_role_name                = var.pipeline_role_name
  recovery_window_in_days           = var.secrets_manager_rds_recovery_window_in_days
  secret_string                     = var.secrets_manager_rds_secret_string
  secondary_region                  = var.secondary_region
  multi_region                      = var.secrets_manager_rds_multi_region
  force_overwrite_replica_secret    = var.secrets_manager_rds_force_overwrite_replica_secret
  replica_kms_key_id                = module.kms_secrets_manager_rds.kms_replica_arn
  create_rotation_secret            = true
  rotation_lambda_arn               = "arn:aws:lambda:${var.primary_region}:${var.account_id_aws}:function:${var.env}-${var.project}-rotation-lambda"
  rotation_automatically_after_days = 90
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.secrets_manager_rds_name}"
      PCI : "No"
      Impact : "Alto"
    },
  )
}

module "kms_cloudwatch_log_group" {
  source = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-kms.git?ref=1.1.3"
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
  alias                                 = "${var.env}-${var.project}-${var.kms_cloudwatch_alias}"
  description                           = var.kms_cloudwatch_description
  multi_region                          = var.kms_cloudwatch_multiregion
  enabled                               = var.kms_cloudwatch_enabled
  create_pipeline_policy                = var.kms_cloudwatch_create_pipeline_policy
  create_admin_principal_policy         = var.kms_cloudwatch_create_admin_principal_policy
  principal_role_name                   = var.kms_cloudwatch_principal_role_name
  pipeline_role_name                    = var.pipeline_role_name
  primary_region                        = var.primary_region
  secondary_region                      = var.secondary_region
  create_service_policy_cloudwatch_logs = var.kms_cloudwatch_create_service_policy_cloudwatch_logs
  log_group_name                        = var.kms_cloudwatch_log_group_name
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.kms_cloudwatch_alias}"
      Impact : "Alto"
    },
  )
}

module "iam_role" {
  source           = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-iam-roles-policies.git?ref=1.18.0"
  primary_region   = var.primary_region
  secondary_region = var.secondary_region
  devops_account   = var.devops_account
  #rds
  rds_proxy_role_enable = var.rds_proxy_role_enable
  rds_proxy_role_name   = "${var.env}-${var.project}-${var.rds_proxy_role_name}"
  rds_proxy_secret_name = ["${var.env}-${var.project}-*"]
  rds_proxy_kms_id      = module.kms_secrets_manager_rds.kms_replica_arn != "" ? ["${module.kms_secrets_manager_rds.kms_id}", "${module.kms_secrets_manager_rds.kms_replica_arn}"] : ["${module.kms_secrets_manager_rds.kms_id}"]
  #lambda
  rotation_lambda_role_enable    = var.rotation_lambda_role_enable
  rotation_lambda_role_name      = "${var.env}-${var.project}-${var.rotation_lambda_role_name}"
  rotation_lambda_rds_arn        = var.rotation_lambda_rds_arn
  rotation_lambda_lambda_name    = "${var.env}-${var.project}-${var.rotation_lambda_lambda_name}"
  rotation_lambda_rdsadmin_arn   = module.secrets_manager_rds.secret_string_singleregion_arn != "" ? module.secrets_manager_rds.secret_string_singleregion_arn : module.secrets_manager_rds.secret_string_multiregion_arn
  rotation_lambda_secret_kms_arn = module.kms_secrets_manager_rds.kms_arn

  rds_proxy_tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.rds_proxy_role_name}"
      PCI : "Si"
      Impact : "Alto"
    },
  )
  rotation_lambda_tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.rotation_lambda_role_name}"
      PCI : "Si"
      Impact : "Alto"
    },
  )
  
  depends_on = [ module.kms_secrets_manager_rds, module.secrets_manager_rds]
}

module "wafv2_lb_acl" {
  source                                                       = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-waf.git?ref=1.4.0"
  wafv2_enable                                                 = var.wafv2_lb_enable
  wafv2_association_enable                                     = var.wafv2_lb_association_enable
  ip_set_web_acl_association_resource_arn                      = var.wafv2_lb_ip_set_web_acl_association_resource_arn
  enable_extra_rules                                           = var.wafv2_lb_enable_extra_rules
  ip_set_name                                                  = "${var.env}-${var.project}-${var.wafv2_lb_ip_set_name}"
  ip_set_description                                           = var.wafv2_lb_ip_set_description
  ip_set_scope                                                 = var.wafv2_lb_ip_set_scope
  ip_set_ip_address_version                                    = var.wafv2_lb_ip_set_ip_address_version
  ip_set_addresses                                             = var.wafv2_lb_ip_set_addresses
  ip_set_group_name                                            = "${var.env}-${var.project}-${var.wafv2_lb_ip_set_group_name}"
  ip_set_group_description                                     = var.wafv2_lb_ip_set_group_description
  ip_set_group_scope                                           = var.wafv2_lb_ip_set_group_scope
  ip_set_group_capacity                                        = var.wafv2_lb_ip_set_group_capacity
  ip_set_group_rule_name                                       = "${var.env}-${var.project}-${var.wafv2_lb_ip_set_group_rule_name}"
  ip_set_group_rule_priority                                   = var.wafv2_lb_ip_set_group_rule_priority
  ip_set_group_rule_label                                      = var.wafv2_lb_ip_set_group_rule_label
  ip_set_group_rule_cloudwatch_metrics_enabled                 = var.wafv2_lb_ip_set_group_rule_cloudwatch_metrics_enabled
  ip_set_group_rule_metric_name                                = var.wafv2_lb_ip_set_group_rule_metric_name
  ip_set_group_rule_sampled_requests_enabled                   = var.wafv2_lb_ip_set_group_rule_sampled_requests_enabled
  ip_set_group_cloudwatch_metrics_enabled                      = var.wafv2_lb_ip_set_group_cloudwatch_metrics_enabled
  ip_set_group_metric_name                                     = var.wafv2_lb_ip_set_group_metric_name
  ip_set_group_sampled_requests_enabled                        = var.wafv2_lb_ip_set_group_sampled_requests_enabled
  ip_set_web_acl_name                                          = "${var.env}-${var.project}-${var.wafv2_lb_ip_set_web_acl_name}"
  ip_set_web_acl_description                                   = var.wafv2_lb_ip_set_web_acl_description
  ip_set_web_acl_scope                                         = var.wafv2_lb_ip_set_web_acl_scope
  ip_set_web_acl_cloudwatch_metrics_enabled                    = var.wafv2_lb_ip_set_web_acl_cloudwatch_metrics_enabled
  ip_set_web_acl_metric_name                                   = var.wafv2_lb_ip_set_web_acl_metric_name
  ip_set_web_acl_sampled_requests_enabled                      = var.wafv2_lb_ip_set_web_acl_sampled_requests_enabled
  ip_set_web_acl_logging_configuration_log_destination_configs = var.wafv2_lb_ip_set_web_acl_logging_configuration_log_destination_configs
  ip_set_group_rule_enabled                                    = var.wafv2_lb_ip_set_group_rule_enabled
  ip_set_web_acl_external_rules                                = var.wafv2_lb_ip_set_web_acl_external_rules
  ip_set_web_acl_tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.wafv2_lb_ip_set_web_acl_name}"
      PCI : "NO"
      Impact : "Alto"
    },
  )
  ip_set_group_tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.wafv2_lb_ip_set_group_name}"
      PCI : "NO"
      Impact : "Alto"
    },
  )
  ip_set_tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-${var.wafv2_lb_ip_set_name}"
      PCI : "NO"
      Impact : "Alto"
    },
  )
}