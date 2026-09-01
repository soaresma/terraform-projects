# Define a locals block for the following common values:
# - project
# - project_owner
# - cost_center
# - managed_by
locals {
  common_tags = {
    Project      = "19-working-locals-prj"
    ProjectOwner = "Silveira, Marcelo"
    CostCenter   = "EA-02345"
    ManagedBy    = "Terraform"
  }

}
