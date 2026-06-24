# GitHub Repository Settings

Use these settings before promoting the repository as a serious portfolio centerpiece.

## About Panel

Set the repository description to:

```text
Enterprise Azure landing zone reference with Terraform, Bicep, governance, security, private AKS, Defender, and GitHub Actions.
```

Recommended topics:

```text
azure
landing-zone
terraform
bicep
enterprise-scale
aks
governance
azure-policy
rbac
devsecops
microsoft-defender
github-actions
infrastructure-as-code
cloud-architecture
zero-trust
```

Recommended website field:

```text
https://github.com/mehtanjitesh-sys/azure-enterprise-landing-zone
```

## Profile Pin

Pin this repository to the GitHub profile so it is visible above older or less relevant work.

Manual path:

1. Go to `https://github.com/mehtanjitesh-sys`.
2. Select **Customize your pins**.
3. Choose `azure-enterprise-landing-zone`.
4. Save.

## Repository Feature Settings

Recommended:

- Enable Issues.
- Enable Discussions only if you want public Q&A.
- Enable Actions.
- Enable Dependabot alerts.
- Enable secret scanning if available.
- Enable branch protection for `main`.

## Branch Protection

Recommended `main` rules:

- Require pull request before merging.
- Require at least one approval.
- Require status checks:
  - `terraform-validate`
  - `bicep-build`
  - `checkov-scan`
- Require conversation resolution.
- Block force pushes.
- Block deletions.

## Why This Matters

The About panel, topics, pinned profile placement, badges, diagrams, and CI evidence are portfolio signals. They help a recruiter or architect understand the repo before reading the code.
