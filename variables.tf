variable "management_group_template_deployments" {
  description = <<EOT
Map of management_group_template_deployments, attributes below
Required:
    - location
    - management_group_id
    - name
Optional:
    - debug_level
    - parameters_content
    - tags
    - template_content
    - template_spec_version_id
EOT

  type = map(object({
    location                 = string
    management_group_id      = string
    name                     = string
    debug_level              = optional(string)
    parameters_content       = optional(string)
    tags                     = optional(map(string))
    template_content         = optional(string)
    template_spec_version_id = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.management_group_template_deployments : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 10 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

