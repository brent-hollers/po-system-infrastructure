output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "ec2_instance_id" {
  description = "EC2 instance ID (n8n server)"
  value       = module.compute.instance_id
}

output "ec2_private_ip" {
  description = "EC2 private IP"
  value       = module.compute.private_ip
}

output "alb_dns_name" {
  description = "ALB DNS name — use this to reach n8n before DNS is set up"
  value       = module.load_balancer.alb_dns_name
}

output "n8n_url" {
  description = "n8n URL (via ALB)"
  value       = var.enable_https ? "https://${var.domain_name}" : "http://${module.load_balancer.alb_dns_name}"
}

output "frontend_url" {
  description = "Frontend URL (CloudFront)"
  value       = var.frontend_domain != "" ? "https://${var.frontend_domain}" : module.frontend.cloudfront_url
}

output "cloudfront_url" {
  description = "Raw CloudFront domain (before custom DNS)"
  value       = module.frontend.cloudfront_url
}

output "s3_bucket_name" {
  description = "S3 bucket name for frontend deployment"
  value       = module.frontend.bucket_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID — needed for GitHub Actions secret"
  value       = module.frontend.cloudfront_distribution_id
}

output "github_actions_role_arn" {
  description = "IAM role ARN — add as GitHub Actions secret AWS_DEPLOY_ROLE_ARN"
  value       = module.cicd.github_actions_role_arn
}

output "cicd_setup_instructions" {
  description = "GitHub Actions setup instructions"
  value       = module.cicd.deployment_instructions
}

output "access_urls" {
  description = "Quick reference"
  value = {
    frontend    = var.frontend_domain != "" ? "https://${var.frontend_domain}" : module.frontend.cloudfront_url
    n8n_backend = var.enable_https ? "https://${var.domain_name}" : "http://${module.load_balancer.alb_dns_name}"
  }
}
