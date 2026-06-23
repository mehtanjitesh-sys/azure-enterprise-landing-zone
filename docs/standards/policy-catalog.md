# Enterprise Azure Policy Catalog

## 1. Policy Philosophy

Policies are the executable form of governance. Standards written in documents are useful, but standards enforced through Azure Policy are what make the platform trustworthy.

Policy effects are selected intentionally:

- `Deny` prevents unacceptable risk.
- `Audit` exposes gaps while teams migrate or remediate.
- `Modify` corrects allowed drift where safe.
- `DeployIfNotExists` deploys required controls such as diagnostics.
- `Disabled` is used only during testing or approved emergency exception.

## 2. Baseline Policies

| Policy | Effect | Scope | Reason |
|---|---|---|---|
| Allowed locations | Deny | Enterprise MG | Prevents unapproved data residency and regional sprawl. |
| Required tags | Deny | Enterprise MG | Enforces owner, cost, environment, criticality, and data classification. |
| Deny public IP | Deny/Audit by MG | Corp, data, AKS | Prevents unmanaged internet exposure. |
| Deny public blob access | Deny | Enterprise MG | Prevents accidental public data exposure. |
| Require storage secure transfer | Deny | Enterprise MG | Enforces encrypted transport. |
| Require Key Vault soft delete | Deny | Enterprise MG | Protects secrets from accidental deletion. |
| Require Key Vault purge protection | Deny for prod | Prod landing zones | Protects critical secrets from malicious purge. |
| Audit AKS private cluster | Audit/Deny | AKS MG | Drives private API server adoption. |
| Audit AKS Azure Policy add-on | Audit | AKS MG | Ensures Kubernetes policy control. |
| Allowed VM SKUs | Deny | Landing zones | Prevents cost and support sprawl. |
| Require diagnostics | DeployIfNotExists | Prod MGs | Ensures logs reach central operations. |
| Defender for Cloud plans | DeployIfNotExists | Prod subscriptions | Ensures posture management and threat detection. |

## 3. Policy Assignment Strategy

| Management Group | Policy Posture |
|---|---|
| `platform` | Strict deny and deploy controls. |
| `identity` | Strict identity, logging, Key Vault, and private access controls. |
| `connectivity` | Strict network, diagnostics, firewall, and route controls. |
| `management` | Strict logging and security controls. |
| `corp` | Deny public exposure, require private endpoints for sensitive services. |
| `online` | Public ingress allowed only through WAF-approved patterns. |
| `data` | Highest data protection baseline. |
| `aks` | Private AKS, Azure Policy, workload identity, logging, and approved SKUs. |
| `avd` | Endpoint, logging, identity, storage, and session host standards. |
| `sandbox` | Budget and region controls, reduced deny posture. |
| `migration` | Audit-first posture with dated transition plan. |

## 4. Exception Rules

An exception must never be a quiet bypass. It must be visible in the risk register.

Required fields:

- Policy name
- Scope
- Requested effect override
- Business reason
- Risk owner
- Expiration date
- Compensating control
- Security approval
- Governance approval

## 5. Policy Maturity Roadmap

| Maturity | Capability |
|---|---|
| Level 1 | Allowed locations, required tags, storage security. |
| Level 2 | Key Vault, public exposure, VM SKU, AKS audit policies. |
| Level 3 | Diagnostic DeployIfNotExists, Defender DeployIfNotExists. |
| Level 4 | Data classification-driven policy assignments. |
| Level 5 | Automated exception expiration and compliance reporting. |
