module "ses" {
  source               = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-ses.git?ref=1.3.0"
  domain               = "${local.envproject}.${var.ses_domain}"
  enabled              = var.ses_enabled
  record_ttl           = var.ses_record_ttl
  verify_dkim          = var.ses_verify_dkim
  verify_domain        = var.ses_verify_domain
  zone_id              = data.aws_route53_zone.global_zone.zone_id
  ses_email            = var.ses_email
  event_enabled        = false
  event_matching_types = ["send", "reject", "bounce", "complaint", "delivery", "open", "click", "renderingFailure"]
}