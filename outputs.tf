output "group_display_name" {
  description = "Display name of the group."
  value       = "grp_${var.dept}-${var.alpha}-${var.env}_custom_sub_owners"
}

output "group_object_id" {
  description = "Object ID of the group."
  value       = local.custom_sub_owners_object_id
}

output "custom_role_resource_id" {
  description = "Resource ID of the custom role."
  value       = azapi_resource.role_no_stacks.id
}

output "custom_role_definition_guid" {
  description = "GUID (name) used for the custom role definition."
  value       = random_uuid.role_no_stacks_guid.result
}

output "custom_role_assignment_id" {
  description = "Role assignment resource ID."
  value = coalesce(
    try(azurerm_role_assignment.custom_no_stacks_assign_hardened[0].id, null),
    try(azurerm_role_assignment.custom_no_stacks_assign_plain[0].id, null)
  )
}
