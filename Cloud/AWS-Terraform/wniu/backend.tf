terraform {
  backend "s3" {
    region  = "us-east-1"
    key     = "wniu-platform/terraform.tfstate"
    encrypt = true
  }
}
