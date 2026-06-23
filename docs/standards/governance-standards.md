# Governance Standards

## 1. Governance Mandate

The cloud platform is governed by default. Any team consuming Azure must inherit the enterprise baseline unless an approved exception exists.

## 2. Required Standards

| Standard | Rule |
|---|---|
| Subscription placement | Every subscription must be assigned to the correct management group. |
| Tags | Required tags must exist on all taggable resources. |
| Regions | Resources must be deployed only to approved Azure regions. |
| Identity | Role assignments must use Entra groups, not direct users. |
| Privilege | Standing Owner access is prohibited except break-glass. |
| Network | Public exposure requires approved ingress pattern. |
| Data | Restricted data must use private endpoints and encryption. |
| Secrets | Secrets must live in Key Vault or approved secret store. |
| Diagnostics | Production resources must emit logs to central operations. |
| Deployment | Production resources must be deployed through pipeline. |

## 3. Policy Enforcement Matrix

| Policy | Effect | Scope | Exception Allowed |
|---|---|---|---|
| Allowed locations | Deny | Tenant root or enterprise MG | Rare |
| Required tags | Deny | Enterprise MG | Temporary only |
| Deny public blob access | Deny | Enterprise MG | No for restricted data |
| Require secure transfer | Deny | Enterprise MG | No |
| Require Key Vault soft delete | Deny | Enterprise MG | No |
| Require Key Vault purge protection | Deny for prod, audit for migration | Prod landing zones | Temporary |
| Deny public IP | Deny for corp/data, audit for online | Landing zones | Yes |
| Audit diagnostics | Audit then deploy | Enterprise MG | Temporary |
| Audit AKS private cluster | Audit/Deny for prod | AKS MG | Temporary |
| Deny unapproved VM SKUs | Deny | Landing zones | Yes |

## 4. Naming Standard

Pattern:

```text
<resource-type>-<org>-<workload>-<environment>-<region>-<instance>
```

Examples:

```text
rg-contoso-app001-prod-eastus-001
vnet-contoso-hub-prod-eastus-001
aks-contoso-app001-prod-eastus-001
kv-contoso-app001-prod-001
acrcontosoapp001prod001
```

## 5. Tag Standard

Required:

```text
Environment
Owner
BusinessUnit
CostCenter
DataClassification
Criticality
ManagedBy
```

Allowed `Environment` values:

```text
prod
nonprod
dev
test
stage
sandbox
shared
```

Allowed `DataClassification` values:

```text
public
internal
confidential
restricted
```

Allowed `Criticality` values:

```text
tier0
tier1
tier2
tier3
```

## 6. Exception Standard

Every exception must include:

- Policy or standard being bypassed
- Scope
- Expiration date
- Business justification
- Risk owner
- Compensating control
- Security approval
- Cloud governance approval

No exception should be permanent. Long-lived exceptions indicate a bad standard or a bad workload design.
