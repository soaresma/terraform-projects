locals {
  role_policies = {
    admin    = ["AdministratorAccess"]
    readonly = ["ReadOnlyAccess"]
    developer = [
      "AmazonEC2FullAccess",
      "AmazonS3FullAccess",
      "AmazonRDSFullAccess"
    ]

  }

  role_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])
}
