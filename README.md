# Subscription Owner [Customer] — No Stacks (Azure RBAC)
**Author:** Andrew Clarke  
**Version:** v0.1

## BLUF
Creates/uses an Entra ID group:
```
grp_{dept}-{aplha}-{env}_custom_sub_owners
```
…then defines a **custom Owner-like role** — **Subscription Owner [Customer]** — that **cannot modify Azure Deployment Stacks**, and assigns it to that group at subscription scope. Optional **RBAC hardening** adds a **role-assignment condition** that prevents this group from granting/removing **Owner**, **User Access Administrator**, or **Role Based Access Control Administrator**.

## Repo Layout
- versions.tf, providers.tf, variables.tf
- group.tf (create/adopt the group)
- role.tf (custom role that blocks stack ops)
- assignments.tf (assign role; optional hardening condition)
- outputs.tf
- terraform.tfvars.example

## Inputs
- subscription_id (string), tenant_id (string)
- dept (string), aplha (string), env (string)
- custom_role_name (string, default: "Subscription Owner [Customer]")
- enable_rbac_hardening (bool, default: true)

## Quick Start
1) Copy terraform.tfvars.example → terraform.tfvars and set values.  
2) `terraform init && terraform apply`

## Notes
- RBAC is additive—remove Owner/UAA/RBAC grants elsewhere.  
- To remove RBAC entirely for this role, add `Microsoft.Authorization/roleAssignments/*` to `notActions` in role.tf and set `enable_rbac_hardening = false`.
