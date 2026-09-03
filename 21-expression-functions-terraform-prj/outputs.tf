# Results of the arithmetic, equality, comparison, and logical operator examples.
output "math_operators" {
  value = {
    math        = local.math
    equality    = local.equality
    comparision = local.comparision
    logical     = local.logical
  }
}

# Numbers produced by doubling each input value.
output "double_numbers" {
  value = local.double_numbers
}

# Numbers retained by the even-number filtering example.
output "even_numbers" {
  value = local.even_numbers
}

# First names produced by the expression-function examples.
output "first_names" {
  value = local.first_names
}

# Full names produced by combining name components.
output "full_names" {
  value = local.full_names
}
# Map of numbers produced by doubling each input value.
output "double_map" {
  value = local.double_map
}

# Map of numbers retained by the even-number filtering example.
output "even_map" {
  value = local.even_map
}

# Complete user map created from the example user data.
output "user_map" {
  value = local.user_map
}

# Transformed user map keyed by the configured user identifier.
output "user_map2" {
  value = local.user_map2
}

# Roles for the user selected by the `user_to_output` variable.
output "user_to_output_roles" {
  value = local.user_map2[var.user_to_output].roles
}

# Usernames extracted from the transformed user map.
output "usernames_from_map" {
  value = local.usernames_from_map
}

# First name extracted from the first user using Terraform's splat expression.
output "first_name_from_splat" {
  value = local.first_name_from_splat
}

# Roles extracted from the first user with Terraform's splat expression.
output "roles_from_splat" {
  value = local.roles_from_splat
}

output "example1" {
  value = startswith(lower(local.name), "philipe")
}

output "example2" {
  value = pow(local.age, 2)
}

output "example3" {
  value = yamldecode(file("${path.module}/users.yaml")).users[*].name
}

output "example4" {
  value = jsonencode(local.my_object)
}
