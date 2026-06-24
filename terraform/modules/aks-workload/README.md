# aks-workload Module

Creates a private AKS-based application landing zone.

## Includes

- Application resource group
- Spoke VNet and AKS subnets
- Log Analytics workspace
- ACR Premium
- Key Vault with RBAC and purge protection
- Private AKS cluster
- OIDC issuer and workload identity
- Key Vault secrets provider
- Azure Policy add-on
- System and user node pools
- Autoscaling

## Notes

Production deployments should add private endpoints, ingress/WAF, route tables, firewall egress, backup, and GitOps or Helm release management.
