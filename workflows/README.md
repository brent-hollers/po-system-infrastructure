# n8n Workflows

## Import / Export

To export a workflow from a running n8n instance:

```bash
n8n export:workflow --id=<workflow-id> --output=workflows/po-approval-workflow.json
```

To import into a new n8n instance:

```bash
n8n import:workflow --input=workflows/po-approval-workflow.json
```

## Workflows

| File | Description |
|------|-------------|
| `po-approval-workflow.json` | Three-stage PO approval: Department Head → Principal → Finance |

## Approval Flow Summary

1. **Trigger** — Staff submits a PO request via the frontend form
2. **Department Head** — receives email with Approve / Reject links
3. **Principal** — receives email after DH approval; can approve or reject
4. **Finance** — receives email after Principal approval; final sign-off
5. **Completion** — approved PO is delivered to the configured destination (TBD)
6. **Rejection** — submitter is notified at any stage if rejected
