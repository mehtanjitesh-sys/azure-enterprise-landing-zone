# AKS Platform Standard

## 1. Mandatory Production Settings

| Area | Standard |
|---|---|
| Cluster access | Private cluster |
| Identity | Managed identity and workload identity |
| RBAC | Entra ID integration and Azure RBAC |
| Networking | Azure CNI and Azure network policy |
| Node pools | Separate system and user pools |
| Autoscaling | Cluster autoscaler enabled |
| Zones | Availability zones where region supports them |
| Registry | ACR Premium, admin disabled |
| Secrets | Key Vault CSI driver and workload identity |
| Policy | Azure Policy add-on enabled |
| Monitoring | Container Insights or managed Prometheus approved pattern |
| Egress | User-defined routing through firewall |

## 2. Workload Requirements

Every production deployment must include:

- CPU and memory requests
- CPU and memory limits
- Readiness probe
- Liveness probe
- Non-root user
- Privilege escalation disabled
- Linux capabilities dropped unless approved
- Immutable image tag
- Namespace label for owner and environment
- Network policy

## 3. Scaling Pattern

| Layer | Tool |
|---|---|
| Pod scaling | Horizontal Pod Autoscaler |
| Event scaling | KEDA |
| Node scaling | AKS cluster autoscaler |
| Global routing | Azure Front Door |
| Regional ingress | Application Gateway WAF or approved ingress controller |

## 4. Release Pattern

Preferred:

```text
GitHub PR -> image build -> scan -> push to ACR -> deploy to nonprod -> approval -> deploy prod
```

For mature teams, use GitOps:

```text
App repo builds image
Platform repo owns cluster
Environment repo owns deployment manifests
GitOps controller reconciles desired state
```

## 5. Day-2 Operations

Required runbooks:

- Cluster upgrade
- Node image upgrade
- Secret rotation
- Certificate renewal
- Scale-out incident
- Failed deployment rollback
- Image vulnerability response
- Namespace onboarding
- Production access request
