terraform {
  cloud {
    organization = "flachen"

    workspaces {
      name = "example-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}
locals {
  project_name = "terraform-aws"
}

resource "aws_instance" "my_server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.instance_type
  tags = {
    Name = "MyService-${local.project_name}"
  }
}

module "vpc" {
  source   = "terraform-aws-modules/vpc/aws"
  providers = {
    aws =  aws.eu 
   }
  name     = "my-vpc"
  cidr     = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}