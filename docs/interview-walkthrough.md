# Interview Walkthrough

Use this guide to discuss the repository with recruiters, hiring managers, cloud architects, and security leaders.

## Opening Position

This repository is an Azure enterprise landing zone reference. It is not meant to be a one-click production deployment for an unknown tenant. It is designed to show how I think through enterprise cloud foundations: governance, identity, policy, security, networking, platform operations, workload onboarding, automation, and evidence.

## How I Would Present It

1. Start with governance.
   - Explain the management group hierarchy.
   - Explain why policy and RBAC are established before workload deployment.
   - Explain how tagging, allowed locations, public exposure controls, and workload standards prevent drift.

2. Move into identity and access.
   - Discuss Okta-to-Entra integration patterns.
   - Explain RBAC, PIM, workload identity, and GitHub OIDC.
   - Explain why long-lived deployment secrets should be avoided.

3. Walk through the platform foundation.
   - Hub-spoke networking.
   - Central logging.
   - Defender for Cloud.
   - Subscription budgets and ownership.
   - Production environment approvals.

4. Walk through the first workload.
   - Private AKS.
   - ACR.
   - Key Vault.
   - Kubernetes namespace, deployment, autoscaling, and security context.
   - How the pattern would scale to more applications.

5. Explain the CI/CD model.
   - Pull requests validate and plan.
   - Production apply is manual and approval-gated.
   - Preflight checks fail clearly when secrets or variables are missing.
   - Checkov reports findings for security triage.

## Strong Interview Points

- I separate architecture intent from tenant-specific configuration.
- I treat governance as the starting point, not an afterthought.
- I use Terraform as the primary enterprise IaC engine and Bicep as an Azure-native companion.
- I avoid automatic production apply on push.
- I use OIDC instead of long-lived GitHub secrets for Azure authentication.
- I treat security findings as backlog, exception, or release-gate decisions based on risk.
- I show both executive and technical architecture views.

## Honest Scope Boundaries

This is a reference implementation. A real enterprise rollout still requires confirmed tenant IDs, subscription IDs, Entra group object IDs, IP ranges, region strategy, licensing, compliance mappings, production approvals, and workload-specific data classification.

That honesty matters. A strong architect does not pretend a generic repo can safely deploy a full company cloud foundation without discovery, approvals, and tenant-specific decisions.

## Questions I Am Ready To Discuss

- How would you structure management groups for a regulated enterprise?
- Where would you place Azure Policy assignments?
- Why private AKS, and what operational tradeoffs does it create?
- How does GitHub OIDC improve deployment security?
- How would you integrate Okta with Microsoft Entra ID?
- What would you enforce with Azure Policy versus CI scanning?
- How would you handle exceptions without weakening governance?
- What would you add before production adoption?
