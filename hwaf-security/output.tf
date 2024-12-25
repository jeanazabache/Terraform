output "kms_vtst_origin_arn" {
  value = module.kms_vtst_origin.kms_arn
}
output "ec2_kms_id" {
  value = module.ec2_kms.kms_id
}

output "ec2_kms_arn" {
  value = module.ec2_kms.kms_arn
}

output "ec2_instance_role_arn" {
  description = "ARN of EC2 Instance Role."
  value       = module.ec2_role.ec2-instance-role-arn
}

output "ec2_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile."
  value       = module.ec2_role.ec2-instance-profile-arn
}

output "ec2_instance_profile_name" {
  description = "Name assigned to the instance profile."
  value       = module.ec2_role.ec2-instance-profile-name
}

output "ec2_sg_id" {
  description = "ID of the security group."
  value       = module.ec2_sg.security_group_id
}

output "nlb_sg_id" {
  description = "ID of the security group."
  value       = module.nlb_sg.security_group_id
}
output "kms_cloudwatch_log_group_arn" {
  value = module.kms_cloudwatch_log_group.kms_arn
}
output "wafv2_wafv2_lb_acl_net_arn" {
  value = module.wafv2_lb_acl.wafv2_webacl_arn
}
output "kms_secrets_manager_rds_arn" {
  value = module.kms_secrets_manager_rds.kms_arn
}
output "secrets_manager_rds_singleregion_arn" {
  value = module.secrets_manager_rds.secret_string_singleregion_arn
}
output "iam_role_lambda_arn" {
  value = module.iam_role.rotation-lambda-role-arn
}