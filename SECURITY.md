# Security Policy

## Supported Version

| Version | Status |
|---|---|
| v1.0.x | Supported reference baseline |

## Reporting Security Issues

Do not open public issues for sensitive security findings. Contact the repository owner directly.

## Secret Handling

Never commit:

- Azure client secrets
- Tenant secrets
- Subscription-specific credentials
- Private keys
- Real tenant IDs
- Real object IDs
- Production IP ranges
- Customer data

Use sample values in `.tfvars.example` and documentation.

## Security Baseline

This repository is designed around:

- Azure Policy
- Azure RBAC
- Entra PIM
- GitHub OIDC
- Microsoft Defender for Cloud
- Defender XDR
- Sentinel-ready logging
- Private AKS
- Key Vault RBAC and purge protection
- CI validation and IaC scanning
