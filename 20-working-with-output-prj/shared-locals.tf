# Define a locals block for the following common values:
# - project
# - project_owner
# - cost_center
# - managed_by
locals {
  Project = "prj-work-outputs"
  # ProjectOwner = "Silveira, Marcelo"
  CostCenter = "EA-02345"
  ManagedBy  = "Terraform"
}

locals {
  common_tags = {
    project = local.Project
    # project_owner = local.ProjectOwner
    cost_center   = local.CostCenter
    managed_by    = local.ManagedBy
    sensitive_tag = var.my_sensitive_value
  }
}
