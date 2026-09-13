output "aws_region" {
  value = var.aws_region
}

output "users_from_yaml" {
  value = local.users_from_yaml
}

output "aws_iam_users" {
  value = aws_iam_user.users
}

output "passwords" {
  value     = { for user, user_login in aws_iam_user_login_profile.users : user => user_login.password }
  sensitive = true
}

output "aws_assume_role" {
  value = { for role, doc in data.aws_iam_policy_document.assume_role : role => doc.json }
}


output "policies" {
  value = local.role_policies_list
}

output "role_policy_attachments" {
  value = aws_iam_role_policy_attachment.role_policy_attachments
}

output "users_roles" {
  value = { for attachment in aws_iam_role_policy_attachment.role_policy_attachments : attachment.id => { role = attachment.role, policy_arn = attachment.policy_arn } }
}

output "assume_role" {
  value = { for role, doc in data.aws_iam_policy_document.assume_role : role => doc.json }
}

