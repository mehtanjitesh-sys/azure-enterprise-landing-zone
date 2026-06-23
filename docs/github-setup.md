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

Add repository secrets:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`

Use Microsoft Entra workload identity federation for GitHub Actions instead of long-lived client secrets.

## Variables

Add repository or environment variables:

- `TF_STATE_RG`
- `TF_STATE_STORAGE_ACCOUNT`
- `TF_STATE_CONTAINER`

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
