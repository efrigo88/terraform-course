locals {
  users_map = {
    for user_info in var.users : user_info.username => user_info.role...
  }
  users_map2 = {
    for user_name, roles in local.users_map : user_name => { roles = roles }
  }
}

output "users_map" {
  value = local.users_map
}

output "users_map2" {
  value = local.users_map2
}
