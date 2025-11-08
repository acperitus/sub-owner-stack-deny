resource "random_uuid" "role_no_stacks_guid" {}

resource "azapi_resource" "role_no_stacks" {
  type      = "Microsoft.Authorization/roleDefinitions@2022-04-01"
  name      = random_uuid.role_no_stacks_guid.result
  parent_id = "/subscriptions/${var.subscription_id}"

  body = {
    properties = {
      roleName    = var.custom_role_name
      description = "Owner-like subscription admin who cannot modify Microsoft.Resources/deploymentStacks."
      type        = "CustomRole"

      permissions = [
        {
          actions = ["*"]
          notActions = [
            "Microsoft.Resources/deploymentStacks/write",
            "Microsoft.Resources/deploymentStacks/delete",
            "Microsoft.Resources/deploymentStacks/manageDenySetting/action",
            "Microsoft.Resources/deploymentStacks/validate/action"
          ]
          dataActions    = []
          notDataActions = []
        }
      ]

      assignableScopes = ["/subscriptions/${var.subscription_id}"]
    }
  }
}
