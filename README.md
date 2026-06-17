# St. Mary's Academy — Purchase Order Management System

Infrastructure-as-code for the St. Mary's Academy PO Management System.

## Architecture

- **Frontend**: Static site (S3 + CloudFront) with Google Sign-In (staff only)
- **Workflow Engine**: n8n on EC2 in a private subnet
- **Load Balancer**: Application Load Balancer (ALB)
- **Monitoring**: CloudWatch dashboards and alarms
- **IaC**: Terraform (modular)

## Approval Flow

1. **Department Head** — reviews and approves/rejects the PO request
2. **Principal** — secondary approval
3. **Finance** — final approval; triggers downstream delivery of approved PO

## Repository Structure

See [PROJECT_STRUCTURE.MD](PROJECT_STRUCTURE.MD) for a full breakdown.

## More details coming soon!
