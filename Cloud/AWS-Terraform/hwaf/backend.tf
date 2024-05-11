terraform {
  backend "s3" {
    region  = "us-east-1"
    key     = "hwaf-platform/terraform.tfstate"
    encrypt = true
  }
}
