data "terraform_remote_state" "hwaf-security-platform" {
  backend = "s3"
  config = {
    bucket         = "${var.env}-${var.account_name}-terraform-state-s3"
    region         = "us-east-1"
    key            = "hwaf-security-platform/terraform.tfstate"
    dynamodb_table = "${var.env}-${var.account_name}-terraform-locks"
    encrypt        = "true"
  }
}
data "aws_subnet" "private_subnets" {
  count = length(var.vpc_private_subnets) > 0 ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["${var.env}-${var.project}-${var.vpc_name}-private-subnet-us-east-1a"]
  }
}
module "regional" {
  source = "./modules/regional"

  # Global variables
  project          = var.project
  env              = var.env
  zone_name        = var.zone_name
  primary_region   = var.primary_region
  secondary_region = var.secondary_region
  account_name        = var.account_name
  enable_cross_region = var.enable_cross_region

  # ROUTE53 HOST ZONE
  data_zone_name                 = "${local.envproject}.${var.zone_name}"
  existing_route53_zone          = var.existing_route53_zone
  create_certificate             = var.create_certificate
  certificate_logging_preference = var.certificate_logging_preference

  # VPC
  vpc_name                   = var.vpc_name
  vpc_enable_dns_support     = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames   = var.vpc_enable_dns_hostnames
  vpc_cidr                   = var.vpc_cidr
  vpc_azs                    = var.vpc_azs
  vpc_private_subnets        = var.vpc_private_subnets
  vpc_public_subnets         = var.vpc_public_subnets
  vpc_database_subnets       = var.vpc_database_subnets
  vpc_enable_nat_gateway     = var.vpc_enable_nat_gateway
  vpc_enable_vpn_gateway     = var.vpc_enable_vpn_gateway
  vpc_one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az
  vpc_single_nat_gateway     = var.vpc_single_nat_gateway
  vpc_transit_gateway_routes = var.vpc_transit_gateway_routes

  # alb
  nlb_security_group_ids  = [data.terraform_remote_state.hwaf-security-platform.outputs.nlb_sg_id]
  port                    = var.port
  vpc_id                  = var.vpc_id
  subnet_id_priv          = data.aws_subnet.private_subnets[0].id
  ssl_policy              = var.ssl_policy
  certificate_arn         = var.certificate_arn

  # Ec2
  create                  = var.create
  vpc_security_group_ids  = [data.terraform_remote_state.hwaf-security-platform.outputs.ec2_sg_id]
  kms_key_id              = data.terraform_remote_state.hwaf-security-platform.outputs.ec2_kms_arn
  ami                     = var.ami
  instance_type           = var.instance_type
  iam_instance_profile    = data.terraform_remote_state.hwaf-security-platform.outputs.ec2_instance_profile_name
  user_data               = var.user_data
  volume_size             = var.volume_size

  # Aurora
  aurora_create_cluster              = var.aurora_create_cluster
  instance_class                     = var.instance_class
  aurora_create_cluster_secondary    = var.aurora_create_cluster_secondary
  database_whitelist                 = var.database_whitelist
  create_global_cluster              = var.create_global_cluster
  serverlessv2_scaling_configuration = var.serverlessv2_scaling_configuration
  engine_mode                        = var.engine_mode
  #Fix para recibir el output con valor
  rds_secret_manager_arn = join("", [data.terraform_remote_state.hwaf-security-platform.outputs.secrets_manager_rds_singleregion_arn])
  rds_kms_key_id         = data.terraform_remote_state.hwaf-security-platform.outputs.kms_secrets_manager_rds_arn

  rotation_rds_users_lambda_role        = data.terraform_remote_state.hwaf-security-platform.outputs.iam_role_lambda_arn
  rotation_rds_users_lambda_kms_key_arn = data.terraform_remote_state.hwaf-security-platform.outputs.kms_secrets_manager_rds_arn
  lambda_logs_kms_key_id                = data.terraform_remote_state.hwaf-security-platform.outputs.kms_cloudwatch_log_group_arn

  # SES
  ses_domain        = var.ses_domain
  ses_enabled       = var.ses_enabled
  ses_record_ttl    = var.ses_record_ttl
  ses_verify_dkim   = var.ses_verify_dkim
  ses_verify_domain = var.ses_verify_domain
  ses_email         = var.ses_email
  
  # BUCKET
  s3_kms_key_id        = data.terraform_remote_state.hwaf-security-platform.outputs.kms_vtst_origin_arn
}