output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets (for ALB)"
  value       = aws_subnet.public[*].id
}

output "private_subnet_id" {
  description = "ID of private subnet (for n8n EC2)"
  value       = aws_subnet.private[0].id
}

output "alb_security_group_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "Security group ID for EC2 (n8n)"
  value       = aws_security_group.ec2.id
}
