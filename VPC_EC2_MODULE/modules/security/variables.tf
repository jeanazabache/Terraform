variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "security_group_rules" {
  description = "List of security group rules"
  type = list(object({
    type                     = string
    protocol                 = string
    from_port                = number
    to_port                  = number
    cidr_blocks              = optional(list(string), [])
    source_security_group    = optional(bool, false)
  }))
}
