# GitHub Setup

## Repository

Create a private GitHub repository, for example:

```text
contoso/azure-enterprise-landing-zone
```

## Environments

Create an environment named `production`.

Add required reviewers:

- Cloud platform lead
- Security architecture reviewer
- Network platform reviewer for network changes

## Secrets

Add these repository secrets so pull request planning and container build workflows can authenticate with OIDC:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

Also add the same three secrets to the protected `production` environment if you want production apply and AKS deploy jobs to require environment approval before the credentials are exposed.

Use Microsoft Entra workload identity federation for GitHub Actions instead of long-lived client secrets.

## Variables

Add these repository variables for automated validation, planning, and build workflows:

- `TF_STATE_RG`
- `TF_STATE_STORAGE_ACCOUNT`
- `TF_STATE_CONTAINER`
- `ACR_NAME`
- `ACR_LOGIN_SERVER`

Add these variables to the protected `production` environment for deployment workflows:

- `TF_STATE_RG`
- `TF_STATE_STORAGE_ACCOUNT`
- `TF_STATE_CONTAINER`
- `AKS_RESOURCE_GROUP`
- `AKS_CLUSTER_NAME`

## Branch Protection

Recommended rules for `main`:

- Require pull request before merging.
- Require at least two approvals.
- Require status checks to pass.
- Require conversation resolution.
- Restrict force pushes.
- Require signed commits where enterprise tooling supports it.

## Manual Approval

The `terraform-apply.yml` workflow uses:

```yaml
environment: production
```

GitHub pauses the job until configured production reviewers approve it.

Terraform apply, container publish, and AKS deploy are intentionally manual-only through `workflow_dispatch`. This keeps the public landing-zone repo professional and enterprise-safe: pull requests can validate and plan automatically, but production-changing actions require an explicit run request plus production environment approval where applicable.

## Portfolio-Friendly Workflow Behavior

Public portfolio repositories should not continuously fail because tenant-specific Azure secrets are intentionally absent. This repository separates validation from deployment:

- Pull request workflows validate IaC and generate plans.
- Manual workflows publish containers, deploy Kubernetes manifests, or apply Terraform.
- Preflight steps fail with direct messages when required secrets or variables are missing.
- Production workflows should be connected to GitHub environments with required reviewers.
