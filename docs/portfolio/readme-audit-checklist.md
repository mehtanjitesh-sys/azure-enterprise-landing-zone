# README Audit Checklist

Use this checklist before sharing the repository as a portfolio centerpiece.

## 1. Executive Signal

- [ ] README explains what the repository is in the first 5 lines.
- [ ] README states this is an enterprise Azure landing zone reference, not a toy sample.
- [ ] README identifies the target audience: executives, architects, platform engineers, security teams, and learners.
- [ ] README links to the executive architecture decision pack.
- [ ] README links to architecture diagrams.
- [ ] README links to the implementation runbook.
- [ ] README explains what decisions the architecture makes.

## 2. Architecture Proof

- [ ] Executive diagram exists and renders in GitHub Mermaid.
- [ ] Technical diagram exists and renders in GitHub Mermaid.
- [ ] Management group model is documented.
- [ ] Subscription model is documented.
- [ ] Hub-spoke network model is documented.
- [ ] Identity model is documented, including Okta to Entra ID.
- [ ] Governance model is documented.
- [ ] Security operations model is documented.
- [ ] AKS workload landing zone is documented.
- [ ] Microsoft 365 / Intune / AVD relationship is documented.

## 3. Governance Proof

- [ ] Azure Policy catalog exists.
- [ ] Required tag model exists.
- [ ] RBAC model exists.
- [ ] PIM / break-glass assumptions are documented.
- [ ] Exception process is documented.
- [ ] Subscription vending standard exists.
- [ ] Cost governance and showback model exists.

## 4. Security Proof

- [ ] SECURITY.md exists.
- [ ] Microsoft Defender security architecture exists.
- [ ] Defender for Cloud baseline is documented.
- [ ] Defender XDR role is documented.
- [ ] Sentinel-ready logging model is documented.
- [ ] Key Vault security posture is documented.
- [ ] AKS/container security posture is documented.
- [ ] No secrets or real tenant identifiers are committed.

## 5. IaC Proof

- [ ] Terraform root module exists.
- [ ] Terraform modules have README files.
- [ ] Bicep examples exist.
- [ ] Kubernetes manifests exist.
- [ ] Terraform remote backend expectation is documented.
- [ ] `terraform.tfvars.example` uses placeholder values only.
- [ ] Sanitized Terraform plan evidence exists.

## 6. Pipeline Proof

- [ ] README badges exist for validation workflows.
- [ ] Terraform validation workflow exists.
- [ ] Terraform plan workflow exists.
- [ ] Terraform apply workflow uses manual approval through GitHub environments.
- [ ] Bicep build/lint workflow exists.
- [ ] Checkov or equivalent IaC security scan exists.
- [ ] Container build workflow exists.
- [ ] Kubernetes deploy workflow exists.
- [ ] Pipeline design document exists.

## 7. Repository Packaging

- [ ] LICENSE exists.
- [ ] CONTRIBUTING.md exists.
- [ ] CODEOWNERS exists.
- [ ] SECURITY.md exists.
- [ ] Release notes exist.
- [ ] v1.0.0 tag exists.
- [ ] README links to the release note.
- [ ] Module README files exist.

## 8. Recruiter / Hiring Manager Test

The repository should answer these questions within 2 minutes:

- [ ] What did this person build?
- [ ] Why does it matter?
- [ ] Is this enterprise-grade or a lab?
- [ ] Can this person explain governance?
- [ ] Can this person think about security?
- [ ] Can this person design with identity in mind?
- [ ] Can this person write IaC?
- [ ] Can this person communicate to executives and engineers?

## 9. Architect Review Test

The repository should answer these questions within 10 minutes:

- [ ] What are the key architecture decisions?
- [ ] What are the enforcement points?
- [ ] How are policies assigned?
- [ ] How are privileged roles handled?
- [ ] How does the pipeline authenticate?
- [ ] How is AKS secured?
- [ ] What is intentionally out of scope?
- [ ] What would need tenant-specific design before deployment?

## 10. Red Flags to Remove Before Sharing

- [ ] No real tenant IDs.
- [ ] No real subscription IDs.
- [ ] No real object IDs.
- [ ] No real public IP ranges.
- [ ] No client names tied to confidential implementation details.
- [ ] No secrets.
- [ ] No local machine paths in documentation.
- [ ] No unfinished TODOs in primary README.
- [ ] No broken Mermaid diagrams.
- [ ] No workflow badges pointing to missing workflows.
