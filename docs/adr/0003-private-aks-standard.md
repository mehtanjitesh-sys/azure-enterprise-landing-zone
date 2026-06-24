# ADR 0003: Private AKS Standard

## Status

Accepted

## Context

AKS is the target container platform for complex workloads. Public control planes and unmanaged egress create avoidable risk.

## Decision

Production AKS clusters are private by default and use Azure CNI, Azure RBAC, Azure Policy, workload identity, autoscaling, ACR Premium, Key Vault, and centralized logging.

## Rationale

- Private API servers reduce exposure.
- Entra-integrated RBAC supports enterprise access governance.
- Workload identity avoids static secrets.
- Autoscaling supports elastic workloads.
- Azure Policy and Defender improve security posture.

## Consequences

- Network and DNS design must support private access.
- Operators need approved access paths.
- Ingress and egress patterns must be designed explicitly.
