output "github_actions_role_arn" {
  description = "Add this as GitHub Actions secret: AWS_DEPLOY_ROLE_ARN"
  value       = aws_iam_role.github_actions.arn
}

output "deployment_instructions" {
  description = "GitHub Actions setup instructions"
  value       = <<-EOT
    Add the following secrets to the GitHub repository:
      AWS_DEPLOY_ROLE_ARN = ${aws_iam_role.github_actions.arn}

    The deploy-frontend.yml workflow will use OIDC to assume this role —
    no AWS access keys needed.
  EOT
}
