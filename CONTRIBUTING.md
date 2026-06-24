# Contributing

This repository is an enterprise landing zone reference. Treat changes like platform changes, not casual sample edits.

## Change Rules

- Use pull requests.
- Keep architecture, Terraform, Bicep, and policy changes traceable.
- Update ADRs when a decision changes.
- Update module READMEs when module inputs or outputs change.
- Do not commit secrets, tenant IDs, subscription IDs, client secrets, private keys, or real user data.
- Use sample values in examples.

## Validation

Before merging:

```bash
terraform fmt -recursive terraform
terraform init -backend=false
terraform validate
az bicep build --file bicep/main.bicep
checkov -d .
```

## Pull Request Checklist

- Architecture impact documented.
- Security impact reviewed.
- Governance or policy changes explained.
- Cost impact considered.
- Rollback or remediation path documented.
- No real tenant secrets or private identifiers included.
