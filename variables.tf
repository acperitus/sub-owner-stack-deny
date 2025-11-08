variable "subscription_id" {
  description = "Target subscription for role and assignments."
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for providers."
  type        = string
}

variable "dept" {
  description = "Entity identifier (e.g., sales)."
  type        = string
}

variable "alpha" {
  description = "Service type (e.g., o)."
  type        = string
}

variable "env" {
  description = "Environment (e.g., dev)."
  type        = string
}

variable "custom_role_name" {
  description = "Display name of the custom role."
  type        = string
  default     = "Sub Admin – No Stacks"
}

variable "enable_rbac_hardening" {
  description = "Attach a condition to the custom role assignment that blocks granting/removing Owner, UAA, RBAC Admin."
  type        = bool
  default     = true
}
