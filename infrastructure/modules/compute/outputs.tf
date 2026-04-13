output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.n8n.id
}

output "private_ip" {
  description = "Private IP address of the n8n EC2 instance"
  value       = aws_instance.n8n.private_ip
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.n8n.arn
}
