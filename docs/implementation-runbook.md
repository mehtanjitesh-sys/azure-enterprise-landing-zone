# Implementation Runbook

## Phase 0: Tenant Readiness

1. Confirm Microsoft Entra tenant ownership.
2. Create two break-glass cloud-only accounts.
3. Enable audit logging and security defaults or Conditional Access baseline.
4. Confirm Microsoft 365 and Entra licensing.
5. Define Okta as identity source of truth or coexistence source.
6. Create Entra groups listed in the architecture document.

## Phase 1: Bootstrap IaC

1. Create an Azure subscription for Terraform state or use the management subscription.
2. Create a resource group, storage account, and blob container for remote state.
3. Enable storage account versioning and soft delete.
4. Assign the pipeline federated identity least-privilege access.
5. Configure GitHub secrets:
   - `AZURE_CLIENT_ID`
   - `AZURE_TENANT_ID`
   - `AZURE_SUBSCRIPTION_ID`
6. Configure GitHub environment `production` with manual reviewers.

## Phase 2: Deploy Governance

1. Deploy management group hierarchy.
2. Assign policy initiatives in audit mode.
3. Assign RBAC to platform groups.
4. Review compliance impact.
5. Move selected controls to deny or modify.

## Phase 3: Deploy Platform

1. Deploy connectivity hub.
2. Deploy management/logging foundation.
3. Enable Defender for Cloud plans according to budget and compliance.
4. Configure private DNS zones.
5. Configure diagnostic routing.

## Phase 4: Deploy First Application Landing Zone

1. Deploy app spoke network.
2. Deploy ACR, Key Vault, Log Analytics, and private AKS.
3. Connect ACR to AKS.
4. Apply Kubernetes RBAC and namespace model.
5. Deploy first container workload through CI/CD.

## Phase 5: EUC and Microsoft 365

1. Configure Intune enrollment.
2. Deploy security baselines in pilot ring.
3. Configure Conditional Access for compliant devices.
4. Deploy AVD host pool pilot.
5. Validate FSLogix and profile storage.

## GitHub Push

This workspace does not currently have Git available on PATH. To push manually from a Git-enabled terminal:

```bash
cd azure-enterprise-landing-zone
git init
git add .
git commit -m "Initial Azure enterprise landing zone reference"
git branch -M main
git remote add origin https://github.com/<org>/<repo>.git
git push -u origin main
```

## Validation Checklist

- Terraform `fmt`, `init`, `validate`, and `plan` pass.
- Bicep build passes.
- Policies assigned in audit first.
- Manual approval required before production apply.
- No secrets committed.
- State backend configured remotely.
- RBAC uses groups, not individual users.
- Break-glass access tested.
- Azure Policy exceptions documented.
