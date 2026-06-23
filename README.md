# Azure Enterprise Landing Zone Reference

This repository is an opinionated Fortune 500-style Azure enterprise landing zone blueprint.

It is built from the point of view of a principal cloud/platform architect who is responsible for the full company cloud foundation: governance, identity, network, security, operations, Microsoft 365/Intune, AVD, AKS, container workloads, CI/CD, and IaC.

## What This Is

This is not a tiny demo. It is an enterprise reference implementation that defines:

- Cloud operating model
- Management group and subscription hierarchy
- Governance standards
- Azure Policy baseline
- Azure RBAC model
- Okta to Microsoft Entra ID identity pattern
- Microsoft 365 and Intune security posture
- Hub-spoke network foundation
- Security operations and logging model
- Azure Virtual Desktop landing zone pattern
- Production AKS application landing zone
- Terraform-first IaC implementation
- Bicep examples for Azure-native teams
- GitHub Actions plan, manual approval, apply, container build, and AKS deploy flows
- Kubernetes workload security and autoscaling examples

## Architecture Docs

Start here:

- `docs/executive-architecture-decision-pack.md`
- `docs/architecture.md`
- `docs/standards/governance-standards.md`
- `docs/standards/policy-catalog.md`
- `docs/standards/subscription-vending-standard.md`
- `docs/standards/security-control-matrix.md`
- `docs/standards/aks-platform-standard.md`
- `docs/standards/platform-operating-model.md`
- `docs/implementation-runbook.md`
- `docs/github-setup.md`

## IaC Structure

```text
terraform/
  envs/prod/
  modules/
    policy/
    rbac/
    management-observability/
    network-hub/
    aks-workload/

bicep/
  main.bicep
  modules/
    governance/
    network/
    aks/

kubernetes/
  app001/
    namespace.yaml
    deployment.yaml
    hpa.yaml
```

## Enterprise Baseline

The Terraform implementation includes:

- Management groups
- Enterprise policy initiative
- Required tags
- Allowed locations
- Public IP guardrail
- Storage public access guardrail
- Storage secure transfer guardrail
- Key Vault soft delete and purge protection guardrails
- AKS private cluster and Azure Policy audits
- VM SKU control
- RBAC assignments
- Management observability workspace
- Platform action group
- Subscription budget alerts
- Hub network starter
- Private AKS workload landing zone
- ACR Premium
- Key Vault Premium
- Log Analytics
- AKS node autoscaling
- Workload identity and OIDC issuer
- Key Vault secrets provider

## Production Deployment Flow

```text
Pull request
  -> Terraform validate and plan
  -> Review
  -> Merge to main
  -> GitHub production environment approval
  -> Terraform apply through OIDC
```

## Important

This repo is a strong enterprise starter, but a real company rollout still requires tenant-specific decisions:

- Tenant ID
- Management group names
- Subscription IDs
- Approved regions
- IP address plan
- Entra group object IDs
- Okta integration pattern
- Microsoft 365 licensing
- Defender/Sentinel licensing
- AVD persona model
- Data classification requirements
- Regulatory compliance mapping

## Recommended First Steps

1. Read `docs/architecture.md`.
2. Review the governance standards.
3. Replace example object IDs in `terraform/envs/prod/terraform.tfvars.example`.
4. Bootstrap Terraform remote state.
5. Configure GitHub OIDC and environments.
6. Run Terraform plan.
7. Apply governance first.
8. Deploy platform services.
9. Deploy the first AKS landing zone.

## Sources

This design follows Microsoft guidance for Azure landing zones, Azure Policy, Azure RBAC, Intune security baselines, and AKS baseline architecture. Links are included in `docs/architecture.md`.
