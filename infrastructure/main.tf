terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
}

module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  subnet_id         = module.networking.private_subnet_id
  security_group_id = module.networking.ec2_security_group_id
  instance_type     = "t3.small"
  n8n_domain        = var.domain_name
  enable_https      = var.enable_https
}

module "load_balancer" {
  source = "./modules/load_balancer"

  project_name          = var.project_name
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  alb_security_group_id = module.networking.alb_security_group_id
  instance_id           = module.compute.instance_id
  enable_https          = var.enable_https
  certificate_arn       = var.certificate_arn
}

module "frontend" {
  source = "./modules/frontend"

  project_name    = var.project_name
  custom_domain   = var.frontend_domain
  certificate_arn = var.certificate_arn
  alb_dns_name    = module.load_balancer.alb_dns_name
}

# DNS is managed manually in SiteGround (smaschool.org is not hosted in Route 53).
# After apply, add these records in SiteGround:
#   purchases.smaschool.org     CNAME  <cloudfront_domain from terraform output>
#   api.purchases.smaschool.org CNAME  <alb_dns_name from terraform output>

module "monitoring" {
  source = "./modules/monitoring"

  project_name               = var.project_name
  aws_region                 = var.aws_region
  instance_id                = module.compute.instance_id
  alb_arn                    = module.load_balancer.alb_arn
  alb_arn_suffix             = module.load_balancer.alb_arn_suffix
  target_group_arn           = module.load_balancer.target_group_arn
  target_group_arn_suffix    = module.load_balancer.target_group_arn_suffix
  cloudfront_distribution_id = module.frontend.cloudfront_distribution_id
  alert_email                = var.alert_email
}

module "cicd" {
  source = "./modules/cicd"

  project_name               = var.project_name
  github_org                 = var.github_org
  github_repo                = var.github_repo
  s3_bucket_name             = module.frontend.bucket_name
  cloudfront_distribution_id = module.frontend.cloudfront_distribution_id
  allowed_branches           = ["main"]
}
