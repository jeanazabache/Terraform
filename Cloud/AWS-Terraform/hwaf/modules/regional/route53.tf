data "aws_route53_zone" "global_zone" {
  name         = var.data_zone_name
  private_zone = false

  depends_on = [ module.route53-zone ]
}

module "route53-zone" {
  source                         = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-route53.git?ref=1.3.0"
  existing_route53_zone          = var.existing_route53_zone
  zone_name                      = "${local.envproject}.${var.zone_name}"
  create_certificate             = var.create_certificate
  certificate_logging_preference = var.certificate_logging_preference
}
