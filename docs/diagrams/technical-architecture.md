# Technical Architecture Diagram

This diagram shows the technical target state for the Azure landing zone reference.

```mermaid
flowchart LR
  subgraph Identity["Identity and Access"]
    Okta["Okta Workforce Identity"]
    Entra["Microsoft Entra ID"]
    PIM["PIM"]
    CA["Conditional Access"]
    Intune["Intune Compliance"]
    Okta --> Entra
    Entra --> PIM
    Entra --> CA
    Intune --> CA
  end

  subgraph Governance["Governance"]
    Root["Tenant Root MG"]
    PlatformMG["platform MG"]
    LZMG["landing-zones MG"]
    AksMG["aks MG"]
    AvdMG["avd MG"]
    Policy["Azure Policy Initiative"]
    RBAC["Group-based RBAC"]
    Root --> PlatformMG
    Root --> LZMG
    LZMG --> AksMG
    LZMG --> AvdMG
    Policy --> Root
    RBAC --> Root
  end

  subgraph Connectivity["Connectivity Subscription"]
    Hub["Hub VNet"]
    Firewall["Azure Firewall"]
    DNS["Private DNS Resolver"]
    Bastion["Azure Bastion"]
    Hub --> Firewall
    Hub --> DNS
    Hub --> Bastion
  end

  subgraph Management["Management Subscription"]
    LAW["Central Log Analytics"]
    Defender["Defender for Cloud"]
    Sentinel["Sentinel-ready Workspace"]
    ActionGroup["Action Group"]
    LAW --> Sentinel
    Defender --> Sentinel
    ActionGroup --> Sentinel
  end

  subgraph Workload["App001 AKS Landing Zone"]
    Spoke["Spoke VNet"]
    AKS["Private AKS"]
    ACR["ACR Premium"]
    KV["Key Vault"]
    PE["Private Endpoints"]
    HPA["HPA / Cluster Autoscaler"]
    Spoke --> AKS
    AKS --> ACR
    AKS --> KV
    KV --> PE
    AKS --> HPA
  end

  subgraph DevOps["Deployment Automation"]
    GitHub["GitHub Repo"]
    Plan["Terraform Plan"]
    Approval["Manual Approval"]
    Apply["Terraform Apply via OIDC"]
    GitHub --> Plan
    Plan --> Approval
    Approval --> Apply
  end

  CA --> GitHub
  Apply --> Governance
  Apply --> Connectivity
  Apply --> Management
  Apply --> Workload
  Firewall --> Spoke
  AKS --> LAW
```

## Technical Message

The platform uses Terraform as the orchestration layer, Bicep as an Azure-native reference path, GitHub Actions for validation and deployment, Azure Policy for guardrails, Entra ID for authorization, and Microsoft Defender/Sentinel-ready telemetry for security operations.
