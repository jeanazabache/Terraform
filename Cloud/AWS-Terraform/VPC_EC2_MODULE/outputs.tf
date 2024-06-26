output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vpc.subnet_ids
}

output "instance_id" {
  description = "The ID of the instance"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "The public IP of the instance"
  value       = module.ec2.instance_public_ip
}
