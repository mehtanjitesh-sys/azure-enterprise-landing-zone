# ADR 0006: Policy as Code

## Status

Accepted

## Context

Written standards are not enough. Enterprise guardrails need to be visible, versioned, reviewed, and deployable.

## Decision

Manage Azure Policy definitions, initiatives, and assignments as code.

## Rationale

- Policy changes become reviewable.
- Enforcement is repeatable across management groups.
- Exceptions can be tracked against known controls.
- Compliance posture can be measured.

## Consequences

- Policy changes require pull request review.
- Deny policies must be tested in pilot scopes.
- Migration landing zones may use audit-first rollout.
