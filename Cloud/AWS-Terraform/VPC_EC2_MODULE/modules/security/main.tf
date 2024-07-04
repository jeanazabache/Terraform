resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [for rule in var.security_group_rules : rule if rule.type == "ingress"]
    content {
      from_port                = ingress.value.from_port
      to_port                  = ingress.value.to_port
      protocol                 = ingress.value.protocol
      cidr_blocks              = lookup(ingress.value, "cidr_blocks", null)
      self                    = ingress.value.source_security_group ? true : false
    }
  }

  dynamic "egress" {
    for_each = [for rule in var.security_group_rules : rule if rule.type == "egress"]
    content {
      from_port                = egress.value.from_port
      to_port                  = egress.value.to_port
      protocol                 = egress.value.protocol
      cidr_blocks              = lookup(egress.value, "cidr_blocks", null)
    }
  }
}
