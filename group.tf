locals {
  env_key    = "${var.dept}-${var.alpha}-${var.env}"
  group_name = "grp_${local.env_key}_custom_sub_owners"
}

data "azuread_groups" "existing" {
  display_names  = [local.group_name]
  ignore_missing = true
}

resource "azuread_group" "custom_sub_owners" {
  count            = length(data.azuread_groups.existing.object_ids) == 0 ? 1 : 0
  display_name     = local.group_name
  description      = "Custom subscription owners (no Deployment Stacks modification)."
  security_enabled = true
  mail_enabled     = false
  visibility       = "Private"

  lifecycle { prevent_destroy = true }
}

locals {
  custom_sub_owners_object_id = coalesce(
    try(azuread_group.custom_sub_owners[0].object_id, null),
    try(data.azuread_groups.existing.object_ids[0], null)
  )
}
