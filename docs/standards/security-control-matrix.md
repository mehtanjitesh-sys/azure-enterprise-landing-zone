# Security Control Matrix

## 1. Control Objectives

The security baseline protects identity, network, data, platform, endpoint, and workload layers.

## 2. Controls

| Domain | Control | Implementation |
|---|---|---|
| Identity | MFA for all users | Entra Conditional Access |
| Identity | Phishing-resistant MFA for admins | Conditional Access authentication strength |
| Identity | Privileged access is time-bound | Entra PIM |
| Identity | No direct user RBAC | Group-based role assignments |
| Identity | Break-glass accounts | Two cloud-only accounts, monitored |
| Endpoint | Device compliance required | Intune compliance policies |
| Endpoint | Disk encryption | BitLocker and platform equivalents |
| Endpoint | Defender onboarding | Microsoft Defender for Endpoint |
| Network | Private by default | Private AKS, private endpoints |
| Network | Controlled egress | Azure Firewall and UDRs |
| Network | WAF for public apps | Front Door WAF or App Gateway WAF |
| Data | Secrets protected | Key Vault RBAC and private endpoint |
| Data | Storage public access blocked | Azure Policy |
| Data | Encryption required | Platform encryption and CMK where required |
| Kubernetes | Private API server | AKS private cluster |
| Kubernetes | Entra-integrated RBAC | AKS Azure RBAC |
| Kubernetes | Policy enforcement | Azure Policy add-on |
| Kubernetes | Non-root containers | Kubernetes security context and policy |
| Kubernetes | Autoscaling | Cluster autoscaler, HPA, KEDA |
| Operations | Central logs | Log Analytics and Sentinel-ready exports |
| Operations | Security posture | Defender for Cloud |
| DevOps | No static Azure secrets | OIDC federated credentials |
| DevOps | Manual prod approval | GitHub environment protection |

## 3. Severity Model

| Finding | Severity |
|---|---|
| Public storage with sensitive data | Critical |
| Owner assigned directly to user | High |
| Production resource outside allowed region | High |
| Key Vault without purge protection | High |
| AKS public API server in prod | High |
| Missing production diagnostics | Medium |
| Missing required tags | Medium |
| Non-production over budget | Medium |

## 4. Security Review Triggers

Security architecture review is mandatory when a change includes:

- New public ingress
- New identity provider federation
- New privileged role model
- New data classification of `restricted`
- New AKS cluster
- New network peering to shared hub
- New exception to deny policies
- New production workload landing zone
