################################################################
#             Global Variables
################################################################
variable "account_name" {}
variable "env" {
  type = string
}
variable "project" {}
variable "primary_region" {
  type = string
}
variable "secondary_region" {}
variable "enable_cross_region" {
  type    = bool
  default = false
}

#################################################################
#           Route 53 - Hosted Zone
#################################################################
variable "zone_name" {}
variable "existing_route53_zone" {}
variable "create_certificate" {}
variable "certificate_logging_preference" {}
variable "data_zone_name" {}
#################################################################
#           Vpc Variables
#################################################################
variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
}
variable "vpc_enable_dns_hostnames" {}
variable "vpc_enable_dns_support" {}
variable "vpc_cidr" {}
variable "vpc_azs" {}
variable "vpc_private_subnets" {}
variable "vpc_public_subnets" {}
variable "vpc_database_subnets" {}
variable "vpc_enable_nat_gateway" {}
variable "vpc_enable_vpn_gateway" {}
variable "vpc_one_nat_gateway_per_az" {}
variable "vpc_single_nat_gateway" {}
variable "vpc_transit_gateway_routes" {}
#################################################################
#           ALB
#################################################################
variable "nlb_security_group_ids" {}
variable "port" {}
variable "vpc_id" {}
variable "subnet_id_priv" {}
variable "ssl_policy" {}
variable "certificate_arn" {}
#################################################################
#           EC2
#################################################################
variable "create" {}
variable "vpc_security_group_ids" {}
variable "kms_key_id" {}
variable "ami" {}
variable "instance_type" {}
variable "iam_instance_profile" {}
variable "user_data" {}
variable "volume_size" {}
#################################################################
#                        RDS
#################################################################
variable "aurora_create_cluster" {
  description = "Creates cluster of Aurora"
}
variable "instance_class" {
  description = "Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling"
}
variable "aurora_create_cluster_secondary" {
  description = "Whether cluster should be created (affects nearly all resources)"
}
variable "rds_secret_manager_arn" {}
variable "rds_kms_key_id" {}
variable "database_whitelist" {
  description = "List CIDRs used to allow access to RDS."
}
variable "create_global_cluster" {
  description = "Boolean used to create an RDS Global Cluster."
  type        = bool
}
variable "serverlessv2_scaling_configuration" {
  default = {}
}
variable "engine_mode" {
  default = null
}
#################################################################
#           Rotation Lambda to SM Aurora
#################################################################

variable "rotation_rds_users_lambda_role" {
  description = "Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources."
}
variable "rotation_rds_users_lambda_kms_key_arn" {
  description = "Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key."
}
variable "lambda_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested."
}
################################################################
#           SES
################################################################
variable "ses_domain" {}
variable "ses_enabled" {}
variable "ses_record_ttl" {}
variable "ses_verify_dkim" {}
variable "ses_verify_domain" {}
variable "ses_email" {
  type    = list(string)
  default = []
}
################################################################
#           SES
################################################################
variable "s3_kms_key_id" {}