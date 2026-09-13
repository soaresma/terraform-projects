# Manage IAM users based on the list of usernames from the YAML file
# Creating IAM users for each username listed in the YAML file
# There are two approaches shown below: one using a map and one using a set.
# The map approach allows for more complex user attributes, while the set approach is simpler and only uses usernames.
# The set approach is used in the active code below.

# resource "aws_iam_user" "users" {
#   for_each = { for user in local.users_from_yaml : user.username => user }
#   name     = each.value.username
# }


resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml[*].username)
  name     = each.value
  # depends_on = [aws_iam_policy.iam_create_user]
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = toset(local.users_from_yaml[*].username)
  user            = each.value
  password_length = 8


  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }

}

resource "aws_iam_role" "roles" {
  for_each           = toset(keys(local.role_policies))
  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.value].json
}

resource "aws_iam_role_policy_attachment" "role_policy_attachments" {
  count      = length(keys(local.role_policies))
  role       = aws_iam_role.roles[local.role_policies_list[count.index].role].name
  policy_arn = data.aws_iam_policy.managed_policies[local.role_policies_list[count.index].policy].arn
}

data "aws_iam_policy_document" "assume_role" {
  for_each = toset(keys(local.role_policies))

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        for username in keys(aws_iam_user.users) : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${username}"
        if contains(local.users_map[username], each.value)

      ]
    }

  }

}

data "aws_iam_policy" "managed_policies" {
  for_each = toset(local.role_policies_list[*].policy)
  arn      = "arn:aws:iam::aws:policy/${each.value}"

}

data "aws_caller_identity" "current" {}
