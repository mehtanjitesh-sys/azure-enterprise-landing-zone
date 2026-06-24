# ADR 0002: Governance-First Design

## Status

Accepted

## Context

Cloud environments become inconsistent when workloads are deployed before identity, policy, RBAC, tagging, budgets, and logging are defined.

## Decision

Deploy governance before workload landing zones.

## Rationale

- Management groups establish inheritance.
- Azure Policy creates enforceable standards.
- RBAC and PIM reduce standing privilege.
- Tags and budgets create cost accountability.
- Logging creates auditability.

## Consequences

- Early work focuses on platform foundation.
- Migration subscriptions may need audit-first enforcement.
- Policy exceptions require documented risk ownership and expiration.
