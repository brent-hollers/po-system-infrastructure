variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "custom_domain" {
  description = "Custom domain for CloudFront (purchases.smaschool.org)"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the custom domain (must be in us-east-1)"
  type        = string
  default     = ""
}

variable "alb_dns_name" {
  description = "ALB DNS name (passed through for reference — not used by CloudFront)"
  type        = string
  default     = ""
}
