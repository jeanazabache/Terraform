################################################################
#             Global Variables
################################################################
account_name       = "vtst"
env                = "dev"
project            = "hwaf"
pipeline_role_name = "devops-pipeline-temp"
primary_region     = "us-east-1"
secondary_region   = "us-west-2"
account_id_aws     = "820370175812"
devops_account     = "203671618155"
################################################################
#             KMS S3 Bucket - vtest
################################################################
kms_frontend_origin_alias                         = "files-s3"
kms_frontend_origin_description                   = "AWS KMS CMK created for files VTST S3 Origin"
kms_frontend_origin_create_s3_service_policy      = true
kms_frontend_origin_create_pipeline_policy        = true
kms_frontend_origin_create_admin_principal_policy = true
kms_frontend_origin_principal_role_name           = ["AWSReservedSSO_AWSAdministratorAccess"]
################################################################
#           EC2 KMS
################################################################
kms_ec2_alias                         = "ec2-kms"
kms_ec2_description                   = "AWS KMS CMK created for EC2"
kms_ec2_principal_role_name           = ["AWSReservedSSO_AWSAdministratorAccess"]
kms_ec2_enabled_replica               = false
kms_ec2_create_pipeline_policy        = true
kms_ec2_create_admin_principal_policy = true
#################################################################
#           EC2 SG
#################################################################
vpc_id                                = "vpc-05bdcb9eca7c6a547"
source_security_group_id              = "sg-097a20ea98e47cc42"
security_group_rules                  = [
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    source_security_group = true
  },
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["10.219.230.10/32"]
  },
  {
    type        = "egress"
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "egress"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "egress"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "egress"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
]
#################################################################
#           ALB SG
#################################################################
nlb_vpc_id                                = "vpc-05bdcb9eca7c6a547"
nlb_source_security_group_id              = ""
nlb_security_group_rules                  = [
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 81
    to_port     = 81
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "egress"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    type        = "egress"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
]
################################################################
#             KMS Secrets Manager RDS
################################################################
kms_secrets_manager_rds_alias                         = "rds-secret-kms"
kms_secrets_manager_rds_description                   = "AWS KMS CMK Created for Secrets Manager - RDS User"
kms_create_secretsmanager_rds_service_policy          = true
kms_secrets_manager_rds_create_pipeline_policy        = true
kms_secrets_manager_rds_create_admin_principal_policy = true
kms_secrets_manager_rds_principal_role_name           = ["AWSReservedSSO_AWSAdministratorAccess"]
kms_secrets_manager_rds_multiregion                   = false
kms_secrets_manager_rds_enabled                       = false
kms_external_backup_account                           = "305339833153"
################################################################
#             RDS Password - Secrets Manager Modules
################################################################
secrets_manager_rds_random_password_length           = 16
secrets_manager_rds_random_password_lower            = true
secrets_manager_rds_random_password_min_lower        = 0
secrets_manager_rds_random_password_number           = true
secrets_manager_rds_random_password_min_numeric      = 0
secrets_manager_rds_random_password_special          = true
secrets_manager_rds_random_password_min_special      = 0
secrets_manager_rds_random_password_upper            = true
secrets_manager_rds_random_password_min_upper        = 0
secrets_manager_rds_random_password_override_special = "!#$%&*()-_=+[]{}<>:?"
secrets_manager_rds_description                      = "Secret used to master user in RDS Aurora"
secrets_manager_rds_name                             = "aurora-secret"
secrets_manager_rds_recovery_window_in_days          = 0
secrets_manager_rds_create_random_password           = true
secrets_manager_rds_secret_string                    = { "username" : "userlima" }
secrets_manager_rds_principal_role_name              = "rds-proxy-role"
secrets_manager_rds_multi_region                     = false
secrets_manager_rds_force_overwrite_replica_secret   = false
################################################################
#             Roles
################################################################
rds_proxy_role_enable                        = true
rds_proxy_role_name                          = "rds-proxy-role"
rotation_lambda_rds_arn                      = "arn:aws:rds:*:*:cluster:*"
rotation_lambda_role_name                    = "rotation-lambda-role"
rotation_lambda_role_enable                  = true
rotation_lambda_lambda_name                  = "rotation-lambda" #Rotation Lambda must contain this string
################################################################
#             KMS Cloudwatch Log Group
################################################################
kms_cloudwatch_alias                                 = "cloudwatch-kms"
kms_cloudwatch_description                           = "AWS KMS CMK Created for Cloudwatch log group"
kms_cloudwatch_multiregion                           = false
kms_cloudwatch_enabled                               = true
kms_cloudwatch_create_pipeline_policy                = true
kms_cloudwatch_create_admin_principal_policy         = true
kms_cloudwatch_principal_role_name                   = ["AWSReservedSSO_AWSAdministratorAccess"]
kms_cloudwatch_create_service_policy_cloudwatch_logs = true
kms_cloudwatch_log_group_name                        = "*"
################################################################
#             WAF v2 - lb
################################################################
wafv2_lb_enable                                                       = true
wafv2_lb_enable_extra_rules                                           = false
wafv2_lb_association_enable                                           = true
wafv2_lb_ip_set_web_acl_association_resource_arn                      = ["arn:aws:elasticloadbalancing:us-east-1:820370175812:loadbalancer/app/dev-hwaf-services-lb/188044dbd33d7260"]
wafv2_lb_ip_set_name                                                  = "waf-lb-acl"
wafv2_lb_ip_set_description                                           = "IP Set used for the WAF - LB"
wafv2_lb_ip_set_scope                                                 = "REGIONAL"
wafv2_lb_ip_set_ip_address_version                                    = "IPV4"
wafv2_lb_ip_set_addresses                                             = ["204.199.165.67/32", "200.48.99.3/32", "204.199.165.131/32", "200.48.99.35/32", "204.199.165.135/32", "200.48.99.39/32", "204.199.165.64/27", "204.199.165.128/27", "200.48.99.0/27", "200.48.99.32/27"]
wafv2_lb_ip_set_group_name                                            = "waf-lb-acl-group"
wafv2_lb_ip_set_group_description                                     = "Rule group for IP Set used for the WAF - LB"
wafv2_lb_ip_set_group_scope                                           = "REGIONAL"
wafv2_lb_ip_set_group_capacity                                        = 2
wafv2_lb_ip_set_group_rule_name                                       = "waf-lb-acl-rule"
wafv2_lb_ip_set_group_rule_priority                                   = 1
wafv2_lb_ip_set_group_rule_label                                      = "ipset-not-compliant"
wafv2_lb_ip_set_group_rule_cloudwatch_metrics_enabled                 = true
wafv2_lb_ip_set_group_rule_metric_name                                = "waf-lb-acl-rule"
wafv2_lb_ip_set_group_rule_sampled_requests_enabled                   = true
wafv2_lb_ip_set_group_cloudwatch_metrics_enabled                      = true
wafv2_lb_ip_set_group_metric_name                                     = "waf-lb-acl-group"
wafv2_lb_ip_set_group_sampled_requests_enabled                        = true
wafv2_lb_ip_set_web_acl_name                                          = "waf-lb-acl"
wafv2_lb_ip_set_web_acl_description                                   = "Web ACL for LB"
wafv2_lb_ip_set_web_acl_scope                                         = "REGIONAL"
wafv2_lb_ip_set_web_acl_cloudwatch_metrics_enabled                    = true
wafv2_lb_ip_set_web_acl_metric_name                                   = "waf-lb-acl"
wafv2_lb_ip_set_web_acl_sampled_requests_enabled                      = true
wafv2_lb_ip_set_web_acl_logging_configuration_log_destination_configs = "arn:aws:s3:::aws-waf-logs-niubiz-centralized"
wafv2_lb_ip_set_group_rule_enabled                                    = false
wafv2_lb_ip_set_web_acl_external_rules                                = []