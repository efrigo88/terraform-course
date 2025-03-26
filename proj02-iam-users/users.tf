locals {
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml"))

  users_map = {
    for config in local.users_from_yaml.users : config.username => config.roles
  }
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_from_yaml.users[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}

# These passwords are only available after the first apply.
# To view them, run one of the following commands:
#   terraform output passwords
#   terraform output -json passwords
#
# Note: Terraform hides sensitive outputs by default, but these commands will display them.
# If you reapply without recreating the login profiles, the passwords will show as null.
output "passwords" {
  sensitive = true
  value = {
    for user, user_login in aws_iam_user_login_profile.users : user => user_login.password
  }
}

output "users_map" {
  value = local.users_map
}
