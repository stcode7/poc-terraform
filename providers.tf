terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket         = "state-terraform-chl"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
  }
}