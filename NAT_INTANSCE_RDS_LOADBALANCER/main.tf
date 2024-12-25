################## PRIVIDERS ##################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/AWS"
      version = "5.51.1"
    }
  }
}