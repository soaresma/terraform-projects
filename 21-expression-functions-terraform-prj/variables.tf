# Locals session:

locals {
  # Examples of arithmetic, equality, comparison, and logical expressions.
  math        = 2 * 2
  equality    = 2 != 2
  comparision = 2 < 1
  logical     = true && false

}

locals {
  # Derived collections generated from the input variables.
  double_numbers = [for numbers in var.number_list : numbers * 2]
  even_numbers   = [for numbers in var.number_list : numbers if numbers % 2 == 0]
  first_names    = [for person in var.object_list : person.first_name]
  full_names     = [for person in var.object_list : "${person.first_name} ${person.last_name}"]
}

locals {
  # Creates a map with the same keys and values multiplied by two.
  double_map = { for key, value in var.numbers_map : key => value * 2 }
  # Creates a map containing only entries whose values are even.
  even_map = { for key, value in var.numbers_map : key => value if value % 2 == 0 }
}

locals {
  # Transforms var.users list into a map keyed by user_name.
  user_map = { for user in var.users : user.user_name => user.role }
}

locals {
  # Converts the user map into a map of objects while preserving each
  # username as the key and wrapping its role value in a roles attribute.
  user_map2 = {
    # Iterate over each username and role in the previously generated map.
    for user_name, roles in local.user_map : user_name => {
      roles = roles
    }
  }
}

locals {
  # Extracts the keys from local.user_map into a list of usernames. Each map
  # entry is visited as username and roles; only the username is retained.
  # Equivalent shorthand: usernames_from_map = keys(local.user_map).
  usernames_from_map = [for username, roles in local.user_map : username]
}

locals {
  # Uses Terraform's splat expression to collect the first_name attribute
  # from every object in var.object_list into a list of strings.
  # first_name_from_splat = var.object_list[*].first_name
  first_name_from_splat = toset(var.object_list)[*].first_name
  # roles_from_splat      = [ for username, user_props in local.user_map2: user_props.roles ]
  roles_from_splat = values(local.user_map2)[*].roles
}

locals {
  name = "Philipe Maison"
  age  = 30
  my_object = {
    key_1 = 10
    key_2 = "my_value"
  }
}

# Variable session:

variable "number_list" {
  # Numbers transformed by the collection expressions above.
  type = list(number)
}

variable "object_list" {
  # Objects containing the names used to build derived name collections.
  type = list(object({
    first_name = string
    last_name  = string
  }))
}

variable "numbers_map" {
  # A map of numbers used for demonstration purposes.
  type = map(number)
}

variable "users" {
  # A list of user objects used to generate the user_map local.
  type = list(object({
    user_name = string
    role      = string
  }))
}

variable "user_to_output" {
  # The user name to output from the user_map2 local.
  type = string
}




