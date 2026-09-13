############################################################
# Principal networking resources for the private IAC module
############################################################

module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "29-main-vpc"
  }
}

