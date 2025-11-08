locals {
  blocked_role_guids = join(",\n        ", [
    "8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
    "18d7d88d-d35e-4fb5-a5c3-7773c20a72d9",
    "f58310d9-a9f6-439a-9e8d-f62e7b41a168"
  ])
}

resource "azurerm_role_assignment" "custom_no_stacks_assign_hardened" {
  count              = var.enable_rbac_hardening ? 1 : 0
  scope              = "/subscriptions/${var.subscription_id}"
  role_definition_id = azapi_resource.role_no_stacks.id
  principal_id       = local.custom_sub_owners_object_id
  principal_type     = "Group"

  condition_version = "2.0"
  condition         = <<-EOT
    (
      !(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})
      OR
      @Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {
        ${local.blocked_role_guids}
      }
    )
    AND
    (
      !(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})
      OR
      @Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {
        ${local.blocked_role_guids}
      }
    )
  EOT
}

resource "azurerm_role_assignment" "custom_no_stacks_assign_plain" {
  count              = var.enable_rbac_hardening ? 0 : 1
  scope              = "/subscriptions/${var.subscription_id}"
  role_definition_id = azapi_resource.role_no_stacks.id
  principal_id       = local.custom_sub_owners_object_id
  principal_type     = "Group"
}
