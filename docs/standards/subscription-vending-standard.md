# Subscription Vending Standard

## 1. Purpose

Subscription vending creates new Azure subscriptions through a repeatable, governed workflow. The goal is to give teams speed without letting unmanaged subscriptions appear in the tenant.

## 2. Required Inputs

Every subscription request must include:

- Business unit
- Workload name
- Environment
- Owner group
- Cost center
- Data classification
- Criticality tier
- Required region
- Network pattern
- Internet exposure requirement
- Compliance scope
- Expected monthly budget

## 3. Vending Workflow

```text
Request -> Governance validation -> Subscription creation -> Management group placement
-> RBAC assignment -> Policy inheritance -> Budget assignment -> Logging configuration
-> Network attachment -> Handoff to workload team
```

## 4. Subscription Baseline

Every vended subscription receives:

- Management group assignment
- Required policy baseline
- Default RBAC assignments
- Budget and alerts
- Activity log export
- Defender for Cloud configuration
- Resource provider registration list
- Network connectivity pattern
- Standard tags

## 5. Approval Rules

| Request Type | Approval |
|---|---|
| Sandbox | Manager and platform approval |
| Non-production workload | App owner and platform approval |
| Production workload | App owner, platform, security, finance |
| Internet-facing production | Security architecture required |
| Restricted data | Security and compliance required |

## 6. Handoff Package

The workload team receives:

- Subscription ID
- Management group path
- Assigned roles
- Network CIDR and DNS guidance
- Policy baseline
- Budget
- Pipeline onboarding instructions
- Exception request process
