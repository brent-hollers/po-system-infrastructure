variable "frontend_domain" {
  description = "Frontend domain (purchases.smaschool.org)"
  type        = string
}

variable "domain_name" {
  description = "n8n backend domain (api.purchases.smaschool.org)"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name (for alias record)"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "CloudFront hosted zone ID (global constant)"
  type        = string
  default     = "Z2FDTNDATAQYW2"
}

variable "alb_dns_name" {
  description = "ALB DNS name (for alias record)"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID (for alias record)"
  type        = string
}
