module "instance_ec2_hwaf" {
  source                      = "git::ssh://git@bitbucket.org/VisaNet_TI/platform-module-ec2.git?ref=1.1.0"
  create                      = var.create
  name                        = "${var.env}-${var.project}-aplication-ec2"
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id_priv
  vpc_security_group_ids      = var.vpc_security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  user_data_replace_on_change = false
  root_block_device = [{
    kms_key_id  = var.kms_key_id
    volume_size = var.volume_size
  }]
  tags = merge(
    local.tags,
    {
      Schedule : "ec2-testing"
    },
  )
}