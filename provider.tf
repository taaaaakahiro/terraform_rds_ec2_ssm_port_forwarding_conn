terraform {
  required_version = ">= 1.4.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.29.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-example-tkoide"
    key     = "rds-ssm-port-forwarding/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}

provider "aws" {
  region = local.region
  default_tags {
    tags = {
      Environment = local.env
    }
  }
}