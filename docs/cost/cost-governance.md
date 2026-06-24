# Cost Governance and Showback Model

## Purpose

Cost governance is part of the landing zone. Every workload must have ownership, budget visibility, and a path for optimization.

## Required Tags

| Tag | Purpose |
|---|---|
| `BusinessUnit` | Showback and executive ownership |
| `CostCenter` | Chargeback/showback mapping |
| `Owner` | Technical accountability |
| `Environment` | Prod/nonprod/sandbox filtering |
| `Criticality` | Resilience and support tier |
| `DataClassification` | Security and compliance posture |
| `ManagedBy` | Terraform, Bicep, or approved exception |

## Budget Model

| Scope | Budget |
|---|---|
| Platform subscription | Monthly budget with 80% actual and 100% forecast alerts |
| Workload subscription | Monthly budget owned by application team |
| Sandbox subscription | Strict low budget and expiration policy |
| Migration subscription | Temporary budget aligned to migration wave |

## Showback Model

Monthly reporting should group spend by:

- Business unit
- Cost center
- Environment
- Workload owner
- Subscription
- Resource type
- Region

## Estimated Monthly Cost Notes

This reference repo does not include a live Infracost estimate because real pricing depends on region, SKUs, usage, Defender plan selection, Sentinel ingestion, Log Analytics retention, AKS node count, egress, and support model.

Recommended next step:

```bash
infracost breakdown --path terraform/envs/prod
infracost diff --path terraform/envs/prod --compare-to infracost-base.json
```

## Cost Risks

| Risk | Control |
|---|---|
| Oversized AKS nodes | Approved SKU policy and autoscaling |
| Sentinel ingestion growth | Data connector scoping and retention tiers |
| Defender plan surprise | Plan-by-plan enablement and budget alerts |
| Sandbox sprawl | Budgets, expiration, and management group policy |
| Untagged resources | Required tag deny policy |
