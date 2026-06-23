# Azure Enterprise Landing Zone Reference

This repository is a Fortune 500-style Azure greenfield reference architecture and IaC starter kit.

It starts with governance, then builds the platform foundation for:

- Azure management groups, subscriptions, policy, and RBAC
- Okta to Microsoft Entra ID identity integration
- Microsoft 365 security, Intune, endpoint governance, and privileged access
- Hub-spoke networking and private connectivity
- Security operations with Microsoft Defender, Sentinel-ready logging, and diagnostics
- Azure Virtual Desktop platform considerations
- First application landing zone using AKS, containers, Azure Container Registry, Key Vault, private networking, and CI/CD
- Terraform and Bicep implementation paths
- GitHub Actions with plan, manual approval, and apply stages

## Important

This is a reference starter, not a one-click production deployment. A real enterprise rollout needs tenant-specific design workshops, subscription IDs, identity group object IDs, IP ranges, compliance mappings, operational owners, DNS zones, connectivity choices, and security exceptions.

## Recommended Order

1. Read `docs/architecture.md`.
2. Fill in `terraform/envs/prod/terraform.tfvars.example` and rename it to `terraform.tfvars`.
3. Create the Terraform state storage account manually or through a bootstrap pipeline.
4. Configure GitHub repository secrets and environments.
5. Run pull request validation.
6. Approve the `production` environment in GitHub Actions.
7. Apply through pipeline.

## Repository Layout

```text
docs/
  architecture.md                  Enterprise architecture document
  implementation-runbook.md         How to roll this out
terraform/
  envs/prod/                        Terraform root module
  modules/policy/                   Azure Policy initiative and assignments
  modules/rbac/                     RBAC assignments
  modules/network-hub/              Hub networking
  modules/aks-workload/             First AKS workload platform
bicep/
  main.bicep                        Bicep orchestration example
  modules/                          Bicep modules for governance, network, AKS
policies/
  custom-allowed-locations.json
  custom-require-tags.json
.github/workflows/
  terraform-plan.yml
  terraform-apply.yml
```

## GitHub Secrets

Use OpenID Connect if possible. Configure:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

Create a GitHub environment named `production` and require manual reviewers. The apply workflow targets that environment.

## Sources

This design follows Microsoft guidance for Azure landing zones, Azure Policy, Azure RBAC, Intune security baselines, and AKS baseline architecture. See the source links in `docs/architecture.md`.
