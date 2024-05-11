provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.primary_region
}

provider "aws" {
  alias                    = "replica"
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.secondary_region
}
