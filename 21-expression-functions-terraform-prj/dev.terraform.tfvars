# Numeric values used to demonstrate Terraform list expression functions.
number_list = [10, 20, 30, 40, 50]

# Objects used to demonstrate Terraform expressions over collections of records.
# Each object contains a person's first and last name.
object_list = [
  {
    first_name = "John"
    last_name  = "Doe"
  },
  {
    first_name = "Jane"
    last_name  = "Smith"
  }
]


numbers_map = {
  one   = 1
  two   = 2
  three = 3
  four  = 4
  five  = 5
}

users = [{
  user_name = "Jake"
  role      = "CTO"
  },
  {
    user_name = "Emily"
    role      = "Enterprise AI Architect"
  },
  {
    user_name = "Michael"
    role      = "Software Engineer"
}]

user_to_output = "Jake"
