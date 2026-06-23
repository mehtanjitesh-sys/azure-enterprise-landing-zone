# Platform Operating Model

## 1. Ownership

| Team | Owns |
|---|---|
| Cloud Governance Board | Standards, exceptions, policy intent |
| Platform Engineering | IaC modules, pipelines, landing-zone factory |
| Identity Team | Okta, Entra ID, PIM, Conditional Access |
| Security Architecture | Security standards and architecture reviews |
| SOC | Monitoring, detection, incident response |
| Network Platform | Hub, firewall, DNS, routing, connectivity |
| EUC Platform | Intune, AVD, endpoint compliance |
| Application Teams | Workload code, app IaC, app operations |
| FinOps | Budgets, chargeback, reserved capacity guidance |

## 2. Decision Rights

| Decision | Owner |
|---|---|
| Allowed regions | Governance + Security |
| Management group hierarchy | Platform + Governance |
| Policy deny controls | Governance |
| Hub-spoke connectivity | Network Platform |
| Public ingress approval | Security Architecture |
| AKS baseline | Platform Engineering |
| Intune compliance | EUC + Security |
| Production deployment approval | App Owner + Platform/Security as needed |

## 3. Change Classes

| Change Type | Example | Approval |
|---|---|---|
| Standard workload change | App deployment inside approved namespace | App team |
| Platform change | AKS module, policy, RBAC, hub route | Platform owner |
| Security-sensitive change | Public ingress, privileged role, policy exemption | Security required |
| Emergency change | Production outage mitigation | Incident commander, post-change review |

## 4. Metrics

Track:

- Policy compliance percentage
- Number of active exceptions
- Exceptions past expiration
- Subscriptions without owners
- Resources missing required tags
- Publicly exposed resources
- Mean time to provision subscription
- Mean time to onboard workload
- Production deployment frequency
- Failed change rate
- Azure spend by business unit
