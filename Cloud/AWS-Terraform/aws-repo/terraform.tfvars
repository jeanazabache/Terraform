###############################################################
#           EC2
###############################################################
instance_name      = "server"
region             = "us-east-1"
vpc_name           = "vpc-virginia"
subnet_count       = 2
subnet_cidrs       = ["10.0.0.0/24", "10.0.1.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
ami                = "ami-04b70fa74e45c3917"
instance_type      = "t3.micro"
cidr_block         = "10.0.0.0/16"
state_public_ip    = true


###############################################################
#           IAM
###############################################################
name_role_iam = "ssm_role"
aws_policy_integrate = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
