###############################################################
#           Global Variables
###############################################################
region             = "us-east-1"
cidr_block         = "10.0.0.0/16"
vpc_name           = "vpc-virginia"
subnet_count       = 2
subnet_cidrs       = ["10.0.0.0/24", "10.0.1.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
ami                = "ami-01b799c439fd5516a"
instance_type      = "t2.micro"
instance_name      = "server"
key_name           = "keypair-v"
