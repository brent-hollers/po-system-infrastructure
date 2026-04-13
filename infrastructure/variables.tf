variable "project_name" {
  description = "Project name used for all resources"
  type        = string
  default     = "st-marys-po"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "domain_name" {
  description = "Domain name for n8n (ALB backend)"
  type        = string
  default     = "api.purchases.smaschool.org"
}

variable "frontend_domain" {
  description = "Domain name for the frontend (CloudFront)"
  type        = string
  default     = "purchases.smaschool.org"
}

variable "certificate_arn" {
  description = <<-EOT
    ACM certificate ARN covering both purchases.smaschool.org and api.purchases.smaschool.org.
    Must be in us-east-1 (required by CloudFront).

    Create once before running terraform apply:
      aws acm request-certificate \
        --domain-name purchases.smaschool.org \
        --subject-alternative-names api.purchases.smaschool.org \
        --validation-method DNS \
        --region us-east-1

    Then add the two CNAME validation records to Route 53 (shown in the ACM console),
    wait for status = ISSUED, and paste the ARN below.
  EOT
  type        = string
  default     = "arn:aws:acm:us-east-1:005608856189:certificate/c4be49d6-5714-4b37-ab17-072d3e7bcfa0"
}

variable "enable_https" {
  description = "Enable HTTPS with ACM certificate"
  type        = bool
  default     = true
}

variable "alert_email" {
  description = "Email address for CloudWatch alarms"
  type        = string
  default     = "bhollers@smaschool.org"
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
  default     = "brent-hollers"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "po-system-infrastructure"
}
