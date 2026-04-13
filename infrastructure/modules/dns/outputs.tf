output "frontend_fqdn" {
  description = "Frontend domain (purchases.smaschool.org)"
  value       = aws_route53_record.frontend.fqdn
}

output "n8n_fqdn" {
  description = "n8n backend domain (api.purchases.smaschool.org)"
  value       = aws_route53_record.n8n.fqdn
}
