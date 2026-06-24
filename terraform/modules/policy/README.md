# policy Module

Defines the enterprise Azure Policy baseline.

## Includes

- Allowed locations
- Required tags
- Deny public IP
- Deny public blob access
- Require secure transfer for storage
- Require Key Vault soft delete
- Audit Key Vault purge protection
- Audit AKS private cluster
- Audit AKS Azure Policy add-on
- Allowed VM SKUs
- Enterprise baseline initiative

## Notes

Start migration subscriptions in audit mode where deny policies could block discovery or remediation.
