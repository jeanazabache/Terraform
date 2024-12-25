module "rds-mysql" {
  source                              = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-aurora.git?ref=feature/mysql-az"
  create_cluster                      = var.aurora_create_cluster
  iam_database_authentication_enabled = local.iam_database_authentication_enabled
  rds_secret_manager_arn              = var.rds_secret_manager_arn
  name                                = "${local.envproject}-mysql-db"
  engine                              = local.engine
  engine_mode                         = var.engine_mode
  engine_version                      = local.engine_version
  instance_class                      = var.instance_class
  create_global_cluster               = var.create_global_cluster

  # Variables para engine mysql
  allocated_storage           = local.allocated_storage
  storage_type                = local.storage_type
  multi_az                    = local.multi_az
  availability_zone           = local.availability_zone
  
  create_cluster_secondary    = var.aurora_create_cluster_secondary
  instances_secondary         = {}
  deletion_protection         = true
  allow_major_version_upgrade = true
  vpc_id                      = module.vpc.vpc_id
  subnets                     = module.vpc.database_subnets
  # allowed_cidr_blocks         = concat(module.vpc.database_subnets_cidr_blocks, module.vpc.private_subnets_cidr_blocks, var.database_whitelist)
  # allowed_security_groups     = [for sg in module.sg_lambdas : sg.security_group_id]

  security_group_egress_rules = {
    to_cidrs = {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Outbound rule to all traffic."
      to_port     = 0
      from_port   = 0
      protocol    = "-1"
    }
  }
  
  skip_final_snapshot = local.skip_final_snapshot
  storage_encrypted   = local.storage_encrypted
  apply_immediately   = local.apply_immediately
  monitoring_interval = 10

  kms_key_id           = var.rds_kms_key_id

  create_monitoring_role          = local.create_monitoring_role
  enabled_cloudwatch_logs_exports = local.enabled_cloudwatch_logs_exports
  iam_role_use_name_prefix        = local.iam_role_use_name_prefix
  iam_role_name                   = "${var.env}-${var.project}-rds-monitoring-role"
  iam_role_description            = local.iam_role_description

  auto_minor_version_upgrade = false

  serverlessv2_scaling_configuration = var.serverlessv2_scaling_configuration

  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-backend-db"
      PCI : "Si"
      Impact : "Alto"
    },
  )
  tags_sg = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-rds-sg"
    },
  )
  cluster_tags = {
    backup-policy : "hwaf-rds"
  }

  # INSTANCE PARAMETERS GROUP
  name_instance_pg   = "${var.env}-${var.project}rds-pgr"
  family_instance_pg = local.parameterg_family_mysql
  tags_instance_pg = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-rds-pgr"
      PCI : "No"
      Impact : "Bajo"
    },
  )
}

module "rotation_lambda_sg" {
  source      = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-security-group.git?ref=1.0.3"
  create_sg   = true
  description = "Security Group used by Rotation Lambda."
  name        = "${var.env}-${var.project}-rotation-lambda-sg"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-rotation-lambda-sg"
      Impact : "Bajo"
    },
  )
  security_group_rules = {
    egress_all = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Outbound rule to all traffic."
    }
    ingress_private_subnet = {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      description = "Inbound rule from private subnets"
      type        = "ingress"
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }
}

module "rotation-rds-users-lambda" {
  source                         = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-lambda.git?ref=1.0.2"
  filename_enabled               = true
  filename                       = "./src/lambda-functions/SecretsManagerRDSMySQLRotationSingleUser.zip"
  function_name                  = "${var.env}-${var.project}-rotation-lambda"
  role                           = var.rotation_rds_users_lambda_role
  rolename                       = "${var.env}-${var.project}-rotation-lambda-role"
  architectures                  = ["x86_64"]
  description                    = "Rotates a Secrets Manager secret for Amazon RDS MySQL credentials using the alternating users rotation strategy."
  handler                        = "lambda_function.lambda_handler"
  kms_key_arn                    = var.rotation_rds_users_lambda_kms_key_arn
  memory_size                    = 128
  package_type                   = "Zip"
  reserved_concurrent_executions = -1
  runtime                        = "python3.7"
  timeout                        = "30"
  variables                      = { "EXCLUDE_CHARACTERS" : "/@\"'\\" }
  ephemeral_storage_size         = 512
  security_group_ids             = ["${module.rotation_lambda_sg.security_group_id}"]
  subnet_ids                     = module.vpc.database_subnets
  maximum_event_age_in_seconds   = 21600
  maximum_retry_attempts         = 2
  action                         = "lambda:InvokeFunction"
  principal                      = "secretsmanager.amazonaws.com"
  source_service_arn             = "secretsmanager"
  statement_id                   = "${var.env}-${var.project}-SecretsManagerRDSMySQLRotationSingleUser"
  lambda_logs_kms_key_id         = var.lambda_logs_kms_key_id
  tags = merge(
    local.tags,
    {
      Name : "${var.env}-${var.project}-rotation-lambda"
      PCI : "SI"
      Impact : "Bajo"
    },
  )
}