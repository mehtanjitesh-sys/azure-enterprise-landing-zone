# ADR 0004: GitHub OIDC Pipeline Authentication

## Status

Accepted

## Context

Long-lived service principal secrets in CI/CD increase risk and rotation overhead.

## Decision

Use GitHub Actions OIDC with Microsoft Entra federated credentials for Azure deployments.

## Rationale

- Removes static Azure secrets from GitHub.
- Supports auditable workload identity.
- Aligns with least privilege.
- Works well with environment approvals and protected branches.

## Consequences

- GitHub environments and branch protections become part of the security boundary.
- Azure role assignments must be scoped carefully.
- Deployment identity must be reviewed like any privileged identity.
