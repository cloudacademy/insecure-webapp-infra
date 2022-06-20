terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

#====================================

module "storage" {
  source = "./modules/storage"

  instance_type = var.db_instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_a_id
  sg_id         = var.postgres_sg_id
}

#====================================

module "application" {
  source = "./modules/application"

  instance_type             = var.app_instance_type
  key_name                  = var.key_name
  subnets                   = [var.subnet_a_id, var.subnet_b_id]
  webserver_sg_id           = var.webserver_sg_id
  postgres_ip               = module.storage.private_ip
  alb_dns                   = var.alb_dns
  target_group_arns         = [var.web_target_group_arn, var.api_target_group_arn]
  iam_instance_profile_name = var.iam_instance_profile_name

  depends_on = [
    module.storage
  ]
}