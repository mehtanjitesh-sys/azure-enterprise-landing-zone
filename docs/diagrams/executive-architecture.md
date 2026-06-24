# Executive Architecture Diagram

This diagram shows the enterprise cloud operating model at decision-maker level.

```mermaid
flowchart TB
  Exec["Executive Steering Committee"] --> Gov["Cloud Governance Board"]
  Gov --> Standards["Enterprise Standards"]
  Gov --> Exceptions["Exception and Risk Register"]
  Standards --> MG["Management Groups"]
  Standards --> Policy["Azure Policy Baseline"]
  Standards --> RBAC["RBAC + PIM"]

  Identity["Okta + Microsoft Entra ID"] --> Access["Conditional Access + Intune Compliance"]
  Access --> Azure["Azure Landing Zones"]
  Access --> M365["Microsoft 365"]
  Access --> AVD["Azure Virtual Desktop"]

  Azure --> Platform["Platform Subscriptions"]
  Azure --> Workloads["Application Landing Zones"]
  Platform --> Hub["Connectivity Hub"]
  Platform --> Mgmt["Management + Observability"]
  Platform --> SecOps["Defender + Sentinel-ready Security Operations"]

  Workloads --> AKS["Private AKS Workload Platform"]
  Workloads --> PaaS["Private PaaS Services"]
  AKS --> CI["GitHub Actions + OIDC + Manual Approval"]

  FinOps["FinOps / Showback"] --> Tags["Required Tags + Budgets"]
  Tags --> Azure
  SecOps --> Gov
```

## Executive Message

The architecture gives the business speed with control: identity determines access, governance defines the rules, platform engineering automates the landing zones, and security operations receives the telemetry needed to protect the estate.
