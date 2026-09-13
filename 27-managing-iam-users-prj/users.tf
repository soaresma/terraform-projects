locals {
  users_from_yaml = yamldecode(file("${path.module}/identity-access-config/userinfo.yaml")).users
  users_map = {
    for user in local.users_from_yaml : user.username => user.roles
  }

}
