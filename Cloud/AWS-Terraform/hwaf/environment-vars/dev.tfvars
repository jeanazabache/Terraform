###############################################################
#           Global Variables
###############################################################
account_name     = "vtst"
env              = "dev"
project          = "hwaf"
global           = true
primary_region   = "us-east-1"
secondary_region = "us-west-2"
#################################################################
#           Route 53 - Hosted Zone
#################################################################
zone_name                      = "afiliarmeniubiz.com.pe"
existing_route53_zone          = false
create_certificate             = true
certificate_logging_preference = "ENABLED"
#################################################################
#           Vpc Variables
#################################################################
vpc_name                               = "networking-vpc"
vpc_enable_dns_hostnames               = true
vpc_enable_dns_support                 = true
vpc_cidr                               = "10.156.176.0/22"
vpc_azs                                = ["us-east-1a", "us-east-1b"]
vpc_private_subnets                    = ["10.156.176.0/24", "10.156.177.0/24"]
vpc_public_subnets                     = ["10.156.178.0/24", "10.156.179.0/25"]
vpc_database_subnets                   = ["10.156.179.128/26", "10.156.179.192/26"]
vpc_enable_nat_gateway                 = false
vpc_enable_vpn_gateway                 = false
vpc_one_nat_gateway_per_az             = false
vpc_single_nat_gateway                 = false
vpc_transit_gateway_routes = [
    {
    destination_cidr_block = "0.0.0.0/0"
    transit_gateway_id     = "tgw-03e9f3d2a999e7569"
    route_table_private    = true
    route_table_database   = true
    }
]
#################################################################
#           ALB
#################################################################
port                    = "443"
vpc_id                  = "vpc-05bdcb9eca7c6a547"
ssl_policy              = "ELBSecurityPolicy-TLS13-1-2-2021-06"
certificate_arn         = "arn:aws:acm:us-east-1:820370175812:certificate/1beb215a-6c36-4cd2-8c74-719b700bc4a8"
################################################################
#           EC2
################################################################
create                  = true
ami                     = "ami-00a120da3784806ff"
instance_type           = "t3a.medium"
volume_size             = "25"
# actualizar por info de proveedor
user_data = ""
#################################################################
# RDS
#################################################################
aurora_create_cluster                    = false
instance_class                           = "db.t3.micro"
aurora_create_cluster_secondary          = false
database_whitelist                       = ["10.150.80.0/20", "10.150.96.0/20", "10.150.64.0/20", "10.150.22.0/24"]
create_global_cluster                    = false
enable_global_write_forwarding_secondary = false
enable_rds_schedule                      = true
serverlessv2_scaling_configuration = {
  max_capacity = 2
  min_capacity = 0.5
}
engine_mode = "provisioned"
################################################################
#           SES
################################################################
ses_domain        = "afiliarmeniubiz.com.pe"
ses_enabled       = true
ses_record_ttl    = 300
ses_verify_dkim   = true
ses_verify_domain = true

ses_email = [
  "iramirez@niubiz.com.pe",
  "sfernandez@niubiz.com.pe",
  "cld_dancajima@niubiz.com.pe",
  "hugo.napa@mdp.com.pe",
  "jean.cipiran@mdp.com.pe",
  "jorge.lopez_consultor@mdp.com.pe"
]
