# ADR 0005: Okta to Microsoft Entra ID Integration

## Status

Proposed

## Context

The enterprise may retain Okta as workforce identity source while Microsoft Entra ID remains the control plane for Azure, Microsoft 365, Intune, Defender, and AVD.

## Decision

Use Okta for workforce identity where required and Microsoft Entra ID for Microsoft cloud authorization, Conditional Access, PIM, and resource access.

## Rationale

- Preserves existing identity investment.
- Allows Microsoft cloud controls to operate natively.
- Supports SCIM provisioning, federation, and Conditional Access integration patterns.

## Consequences

- Break-glass accounts must remain cloud-only.
- Federation changes require rollback planning.
- Group lifecycle and authorization boundaries must be documented.
