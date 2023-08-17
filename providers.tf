provider "aws" {
  region  = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "git-sre-ops-tf-states"
    key    = "global/services/git-sre-ops-tfs.tfstate"
    region = "us-east-1"
    encrypt        = true
    dynamodb_table = "global-git-sre-ops-files-terraform-table"
  }
}