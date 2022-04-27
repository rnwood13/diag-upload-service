
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.11.0, < 5.0.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.vpc_region

  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "rnwood13"
      Terraform   = "True"
      Project     = var.project_name
    }
  }
}
