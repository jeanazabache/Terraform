################################################################
#             Global Variables
################################################################
variable "account_name" {
  description = "Account's name"
}
variable "env" {
  description = "Environment's name"
}
variable "project" {
  description = "Project's name"
}
variable "primary_region" {
  description = "Primary region"
}
variable "secondary_region" {
  description = "Secondary region"
}
variable "enable_cross_region" {
  type    = bool
  default = false
}
variable "global" {
  description = "Deploy global module"
  type        = bool
}
#################################################################
#           Route 53 - Hosted Zone
#################################################################
variable "zone_name" {
  description = "Hosted zone ID"
}
variable "existing_route53_zone" {
  description = "Existing hosted zone"
}
variable "create_certificate" {
  default = "Create certificate acm"
}
variable "certificate_logging_preference" {
  description = "Certificate logging preference"
}
#################################################################
#           Vpc Variables
#################################################################
variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
}
variable "vpc_enable_dns_hostnames" {}
variable "vpc_enable_dns_support" {}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}
variable "vpc_azs" {
  description = "A list of availability zones names or ids in the region"
}
variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
}
variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
}
variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}
variable "vpc_enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
}
variable "vpc_one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
}
variable "vpc_single_nat_gateway" {
  description = "Should be true if you want single nat gateway of your private networks"
}
variable "vpc_database_subnets" {
  description = "A list of database subnets"
}
variable "vpc_transit_gateway_routes" {}
#################################################################
#           NLB
#################################################################
variable "port" {}
variable "vpc_id" {}
variable "ssl_policy" {}
variable "certificate_arn" {}
#################################################################
#           EC2
#################################################################
variable "create" {}
variable "ami" {}
variable "instance_type" {}
variable "user_data" {}
variable "volume_size" {}
#################################################################
#                        Aurora
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
variable "enable_global_write_forwarding_secondary" {
  description = "Whether cluster should forward writes to an associated global cluster. Applied to secondary clusters to enable them to forward writes to an aws_rds_global_cluster's primary cluster."
  type        = bool
}
variable "enable_rds_schedule" {
  description = "Enable tag RDS schedule"
  type        = bool
  default     = false
}
variable "rds_secret_manager_arn" {
  default = ""
}
#################################################################
#                        SES
#################################################################
variable "ses_domain" {}
variable "ses_enabled" {}
variable "ses_record_ttl" {}
variable "ses_verify_dkim" {}
variable "ses_verify_domain" {}
variable "ses_email" {
  type    = list(string)
  default = []
}