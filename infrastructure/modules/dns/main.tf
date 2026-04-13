# Look up the existing smaschool.org hosted zone
data "aws_route53_zone" "main" {
  name         = "smaschool.org"
  private_zone = false
}

# A record — purchases.smaschool.org → CloudFront (frontend)
resource "aws_route53_record" "frontend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.frontend_domain
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

# A record — api.purchases.smaschool.org → ALB (n8n backend / webhooks)
resource "aws_route53_record" "n8n" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
