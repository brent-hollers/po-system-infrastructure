variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "subnet_id" {
  description = "Private subnet ID for EC2 instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "n8n_domain" {
  description = "Domain name for n8n webhooks (e.g. api.purchases.smaschool.org)"
  type        = string
  default     = ""
}

variable "enable_https" {
  description = "Enable HTTPS for n8n"
  type        = bool
  default     = true
}
