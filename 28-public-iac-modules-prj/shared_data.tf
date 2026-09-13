##############################################
# Shared Data for the Project
##############################################

locals {
  project_name = "28-public-iac"
  common_tags = {
    Project  = local.project_name
    ManageBy = "Terraform"
  }

}
