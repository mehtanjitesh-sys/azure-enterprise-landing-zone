# ADR 0001: Terraform Primary, Bicep Secondary

## Status

Accepted

## Context

The platform needs a repeatable IaC approach for Azure management groups, policy, RBAC, networking, AKS, security, and future integrations.

## Decision

Use Terraform as the primary orchestration language and Bicep as the Azure-native reference implementation path.

## Rationale

- Terraform is widely adopted for enterprise platform engineering.
- Terraform can coordinate Azure and adjacent systems such as GitHub.
- Remote state and plan/apply workflows are mature.
- Bicep remains useful for Azure-native teams and ARM-aligned modules.

## Consequences

- Terraform owns production lifecycle unless explicitly delegated.
- Bicep examples must not manage the same live resources unless ownership boundaries are documented.
