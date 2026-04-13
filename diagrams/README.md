# Architecture Diagrams

Generated using the [diagrams](https://diagrams.mingrammer.com/) Python library.

## Setup

```bash
pip install -r requirements.txt
python generate_diagrams.py
```

Outputs are written to `output/` (git-ignored). Diagrams include:

- `architecture.png` — full system overview
- `network_topology.png` — VPC layout, subnets, NAT, ALB
- `monitoring_flow.png` — CloudWatch alarms and SNS notification paths
