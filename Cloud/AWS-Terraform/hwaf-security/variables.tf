################################################################
#             Global Variables
################################################################
variable "account_name" {
  description = "Account AWS name."
  type        = string
}
variable "env" {
  description = "Environment of the resource."
  type        = string
}
variable "project" {
  description = "Project name of the resource."
  type        = string
}
variable "pipeline_role_name" {
  description = "Role name of the pipeline, in order to allow it the use within the resource-based policies."
  type        = string
}
variable "primary_region" {
  description = "Primary region of the project."
  type        = string
}
variable "secondary_region" {
  description = "Secondary region of the project."
  type        = string
}
variable "devops_account" {
  description = "DevOps Account Number used to assume role."
  type        = string
}
variable "profile" {
  type    = string
  default = ""
}
variable "account_id_aws" {
  description = "Account ID of AWS"
  type        = string
}
################################################################
#             KMS S3 Bucket - vtest
################################################################
variable "kms_frontend_origin_alias" {
  description = "Alias friendly name used to identify the key used by vtest in S3 bucket."
  type        = string
}
variable "kms_frontend_origin_description" {
  description = "The description of the key used by vtest in S3 bucket as viewed in AWS console."
  type        = string
}
variable "kms_frontend_origin_principal_role_name" {
  description = "Specifies the Principal Role Name"
  type        = set(string)
}
variable "kms_frontend_origin_create_s3_service_policy" {
  description = "Boolean used to create S3 Service Policy."
  type        = bool
}
variable "kms_frontend_origin_create_pipeline_policy" {
  description = "Boolean used to create Pipeline Policy."
  type        = bool
}
variable "kms_frontend_origin_create_admin_principal_policy" {
  description = "Boolean used to create Admin Principal Policy."
  type        = bool
}
################################################################
#             EC2 KMS
################################################################
variable "kms_ec2_alias" {
  description = "Alias friendly name used to identify the key used by EC2."
  type        = string
}
variable "kms_ec2_description" {
  description = "The description of the key used by EC2 as viewed in AWS console."
  type        = string
}
variable "kms_ec2_principal_role_name" {
  description = "Specifies the Principal Role Name"
  type        = set(string)
}
variable "kms_ec2_enabled_replica" {
  description = "Specifies whether the replica key is enabled. Disabled KMS keys cannot be used in cryptographic operations."
  type        = bool
}
variable "kms_ec2_create_pipeline_policy" {
  description = "Boolean used to create Pipeline Policy."
  type        = bool
}
variable "kms_ec2_create_admin_principal_policy" {
  description = "Boolean used to create Admin Principal Policy."
  type        = bool
}

#################################################################
#           EC2 SG
#################################################################
variable "vpc_id" {
  description = "vpc id"
}
variable "security_group_rules" {
  description   = "Security group rules for ingress and egress traffic"
}
variable "source_security_group_id" {}

#################################################################
#           NLB SG
#################################################################
variable "nlb_vpc_id" {
  description = "vpc id"
}
variable "nlb_security_group_rules" {
  description   = "Security group rules for ingress and egress traffic"
}
variable "nlb_source_security_group_id" {}
################################################################
#             KMS Secrets Manager RDS
################################################################
variable "kms_secrets_manager_rds_alias" {
  description = "Alias friendly name used to identify the key used by Secrets Manager."
  type        = string
}
variable "kms_secrets_manager_rds_description" {
  description = "The description of the key used by Secrets Manager as viewed in AWS console."
  type        = string
}
variable "kms_create_secretsmanager_rds_service_policy" {
  description = "Boolean used to create Secrets Manager Service Policy."
  type        = bool
}
variable "kms_secrets_manager_rds_principal_role_name" {
  description = "Specifies the Principal Role Name"
  type        = set(string)
}
variable "kms_secrets_manager_rds_create_pipeline_policy" {
  description = "Boolean used to create Pipeline Policy."
  type        = bool
}
variable "kms_secrets_manager_rds_create_admin_principal_policy" {
  description = "Boolean used to create Admin Principal Policy."
  type        = bool
}
variable "kms_secrets_manager_rds_multiregion" {
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
  type        = bool
}
variable "kms_secrets_manager_rds_enabled" {
  description = "Specifies whether the replica key is enabled. Disabled KMS keys cannot be used in cryptographic operations."
  type        = bool
}
variable "kms_rds_create_rds_external_permission_service_policy" {
  description = "Boolean used to allow an external account to use this KMS key for RDS."
  type        = bool
  default     = true
}
variable "kms_dynamodb_create_dynamodb_external_permission_service_policy" {
  description = "Boolean used to allow an external account to use this KMS key for DDB."
  type        = bool
  default     = true
}
variable "kms_external_backup_account" {
  type        = string
  description = "Enter your backup account"
}
################################################################
#             RDS Password - Secrets Manager Modules
################################################################
variable "secrets_manager_rds_random_password_length" {
  description = "The length of the string desired."
  type        = number
}
variable "secrets_manager_rds_random_password_lower" {
  description = "Include lowercase alphabet characters in the result."
  type        = bool
}
variable "secrets_manager_rds_random_password_min_lower" {
  description = "Minimum number of lowercase alphabet characters in the result."
  type        = number
}
variable "secrets_manager_rds_random_password_number" {
  description = "Include numeric characters in the result."
  type        = bool
}
variable "secrets_manager_rds_random_password_min_numeric" {
  description = "Minimum number of numeric characters in the result."
  type        = number
}
variable "secrets_manager_rds_random_password_special" {
  description = "Include special characters in the result. These are !@#$%&*()-_=+[]{}<>:? ."
  type        = bool
}
variable "secrets_manager_rds_random_password_min_special" {
  description = "Minimum number of special characters in the result."
  type        = number
}
variable "secrets_manager_rds_random_password_upper" {
  description = "Include uppercase alphabet characters in the result."
  type        = bool
}
variable "secrets_manager_rds_random_password_min_upper" {
  description = "Minimum number of uppercase alphabet characters in the result."
  type        = number
}
variable "secrets_manager_rds_random_password_override_special" {
  description = "Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument. The special argument must still be set to true for any overwritten characters to be used in generation."
  type        = string
}
variable "secrets_manager_rds_description" {
  description = "Description of the secret."
  type        = string
}
variable "secrets_manager_rds_name" {
  description = "Friendly name of the new secret. The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@-"
  type        = string
}
variable "secrets_manager_rds_recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days."
  type        = number
}
variable "secrets_manager_rds_create_random_password" {
  description = "Specify whether the module needs to create a random password or not."
  type        = bool
}
variable "secrets_manager_rds_secret_string" {
  description = "Specify the secret string block. Don't send sensitive information like passwords, tokens."
  type        = map(string)
}
variable "secrets_manager_rds_principal_role_name" {
  description = "Name of the role which could Get the value of the secret."
  type        = string
}
variable "secrets_manager_rds_multi_region" {
  description = "Specify whether the secret need to be replicated in other regions."
  type        = bool
}
variable "secrets_manager_rds_force_overwrite_replica_secret" {
  description = "Accepts boolean value to specify whether to overwrite a secret with the same name in the destination Region."
  type        = bool
}
################################################################
#             Roles
################################################################
variable "rds_proxy_role_enable" {
  description = "Specifies whether to enable the RDS Proxy Role or not."
  type        = bool
}
variable "rds_proxy_role_name" {
  description = "Role name used by RDS Proxy"
  type        = string
}
variable "rotation_lambda_role_enable" {
  description = "Specifies whether to enable the Rotation Lambda Role or not."
  type        = bool
}
variable "rotation_lambda_role_name" {
  description = "Role name of the lambda used for user rotation in RDS."
  type        = string
}
variable "rotation_lambda_rds_arn" {
  description = "RDS ARN used by lambda to rotate users."
  type        = string
}
variable "rotation_lambda_lambda_name" {
  description = "Lambda name used to rotate users."
  type        = string
}
################################################################
#             KMS Cloudwatch Log Group
################################################################
variable "kms_cloudwatch_alias" {}
variable "kms_cloudwatch_description" {}
variable "kms_cloudwatch_multiregion" {}
variable "kms_cloudwatch_enabled" {}
variable "kms_cloudwatch_create_pipeline_policy" {}
variable "kms_cloudwatch_create_admin_principal_policy" {}
variable "kms_cloudwatch_principal_role_name" {}
variable "kms_cloudwatch_create_service_policy_cloudwatch_logs" {}
variable "kms_cloudwatch_log_group_name" {}
################################################################
#             WAF v2 - lb
################################################################
variable "wafv2_lb_enable" {
  description = "Specifies wheter to enable WAF or not."
  type        = bool
}
variable "wafv2_lb_ip_set_name" {
  description = "A friendly name of the IP set."
  type        = string
}
variable "wafv2_lb_enable_extra_rules" {
  description = "Boolean used to enable extra rules. Set to false if you need to add manually Fortinet ruleset."
  type        = bool
  default     = false
}
variable "wafv2_lb_ip_set_description" {
  description = "A friendly description of the IP set."
  type        = string
}
variable "wafv2_lb_ip_set_scope" {
  description = "Specifies whether this is for an AWS lb or for a regional application. Valid values are lb or REGIONAL. To work with lb, you must also specify the Region US East (N. Virginia)."
  type        = string
}
variable "wafv2_lb_ip_set_ip_address_version" {
  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6."
  type        = string
}
variable "wafv2_lb_ip_set_addresses" {
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports all address ranges for IP versions IPv4 and IPv6."
  type        = list(string)
}
variable "wafv2_lb_ip_set_group_name" {
  description = "A friendly name of the rule group."
  type        = string
}
variable "wafv2_lb_ip_set_group_description" {
  description = "A friendly description of the rule group."
  type        = string
}
variable "wafv2_lb_ip_set_group_scope" {
  description = "Specifies whether this is for an AWS lb or for a regional application. Valid values are lb or REGIONAL. To work with lb, you must also specify the region us-east-1 (N. Virginia) on the AWS provider."
  type        = string
}
variable "wafv2_lb_ip_set_group_capacity" {
  description = "The web ACL capacity units (WCUs) required for this rule group."
  type        = number
}
variable "wafv2_lb_ip_set_group_rule_name" {
  description = "A friendly name of the rule."
  type        = string
}
variable "wafv2_lb_ip_set_group_rule_priority" {
  description = "If you define more than one Rule in a WebACL, AWS WAF evaluates each request against the rules in order based on the value of priority. AWS WAF processes rules with lower priority first."
  type        = string
}
variable "wafv2_lb_ip_set_group_rule_label" {
  description = "Labels to apply to web requests that match the rule match statement."
  type        = string
}
variable "wafv2_lb_ip_set_group_rule_cloudwatch_metrics_enabled" {
  description = "A boolean indicating whether the associated resource sends metrics to CloudWatch."
  type        = bool
}
variable "wafv2_lb_ip_set_group_rule_metric_name" {
  description = "A friendly name of the CloudWatch metric. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example All and Default_Action."
  type        = string
}
variable "wafv2_lb_ip_set_group_rule_sampled_requests_enabled" {
  description = "A boolean indicating whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console."
  type        = bool
}
variable "wafv2_lb_ip_set_group_cloudwatch_metrics_enabled" {
  description = "A boolean indicating whether the associated resource sends metrics to CloudWatch."
  type        = bool
}
variable "wafv2_lb_ip_set_group_metric_name" {
  description = "A friendly name of the CloudWatch metric. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example All and Default_Action."
  type        = string
}
variable "wafv2_lb_ip_set_group_sampled_requests_enabled" {
  description = "A boolean indicating whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console."
  type        = bool
}
variable "wafv2_lb_ip_set_web_acl_name" {
  description = "Friendly name of the WebACL."
  type        = string
}
variable "wafv2_lb_ip_set_web_acl_description" {
  description = "Friendly description of the WebACL."
  type        = string
}
variable "wafv2_lb_ip_set_web_acl_scope" {
  description = "Specifies whether this is for an AWS lb distribution or for a regional application. Valid values are lb or REGIONAL. To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider."
  type        = string
}
variable "wafv2_lb_ip_set_web_acl_cloudwatch_metrics_enabled" {
  description = "A boolean indicating whether the associated resource sends metrics to CloudWatch."
  type        = bool
}
variable "wafv2_lb_ip_set_web_acl_metric_name" {
  description = "A friendly name of the CloudWatch metric. The name can contain only alphanumeric characters (A-Z, a-z, 0-9) hyphen(-) and underscore (_), with length from one to 128 characters. It can't contain whitespace or metric names reserved for AWS WAF, for example All and Default_Action."
  type        = string
}
variable "wafv2_lb_ip_set_web_acl_sampled_requests_enabled" {
  description = "A boolean indicating whether AWS WAF should store a sampling of the web requests that match the rules. You can view the sampled requests through the AWS WAF console."
  type        = bool
}
variable "wafv2_lb_ip_set_web_acl_logging_configuration_log_destination_configs" {
  description = "The Amazon Kinesis Data Firehose, Cloudwatch Log log group, or S3 bucket Amazon Resource Names (ARNs) that you want to associate with the web ACL."
  type        = string
}
variable "wafv2_lb_association_enable" {
  description = "Enabler for association waf with elb"
  type        = bool
  default     = false
}
variable "wafv2_lb_ip_set_web_acl_association_resource_arn" {
  description = "api gateway arn for association"
  type        = list(string)
  default     = []
}
variable "wafv2_lb_ip_set_web_acl_external_rules" {}
variable "wafv2_lb_ip_set_group_rule_enabled" {}