# Project Structure

```
po-system-infrastructure/
├── .github/
│   └── workflows/
│       └── deploy-frontend.yml       # CI/CD: build & sync frontend to S3
├── diagrams/
│   ├── generate_diagrams.py          # Python script to render architecture diagrams
│   ├── requirements.txt
│   └── output/                       # Generated PNG/SVG diagrams (git-ignored)
├── frontend/
│   └── index.html                    # Single-page app shell (Google Sign-In, PO form)
├── infrastructure/
│   ├── backend.tf                    # Remote state (S3 + DynamoDB)
│   ├── main.tf                       # Root module — wires all child modules
│   ├── outputs.tf
│   ├── variables.tf
│   ├── bootstrap/
│   │   └── main.tf                   # One-time: creates state bucket & lock table
│   └── modules/
│       ├── cicd/                     # IAM role + S3 deploy policy for GitHub Actions
│       ├── compute/                  # EC2 (n8n), security groups, IAM instance profile
│       ├── dns/                      # Route 53 records
│       ├── frontend/                 # S3 bucket + CloudFront distribution
│       ├── load_balancer/            # ALB, target group, listeners, HTTPS cert
│       ├── monitoring/               # CloudWatch dashboards, alarms, SNS topics
│       └── networking/               # VPC, public/private subnets, NAT gateway, IGW
└── workflows/
    ├── README.md                     # How to import/export n8n workflows
    └── po-approval-workflow.json     # n8n workflow: 3-stage PO approval
```
