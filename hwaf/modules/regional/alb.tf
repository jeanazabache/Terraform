resource "aws_lb" "lb" {
  #checkov:skip=CKV_AWS_91:Ensure the ELBv2 (Application/Network) has access logging enabled.
  #checkov:skip=CKV_AWS_150:Ensure that Load Balancer has deletion protection enabled.
  #checkov:skip=CKV2_AWS_28:Ensure public facing ALB are protected by WAF.
  name                             = "${var.env}-${var.project}-services-lb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = var.nlb_security_group_ids
  subnets                          = module.vpc.public_subnets
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true
}

resource "aws_lb_target_group" "lb_target_group" {
  name         = "tg-${var.env}-${var.project}-app-services"
  port         = "80"
  protocol     = "HTTP"
  target_type  = "instance"
  vpc_id       = var.vpc_id
  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
  # depends_on   = [
  #   local.ec2_ids_list
  # ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count             = length(local.ec2_ids_list)
  target_group_arn  = aws_lb_target_group.lb_target_group.arn
  target_id         = element(local.ec2_ids_list, count.index)
  port              = var.port
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}