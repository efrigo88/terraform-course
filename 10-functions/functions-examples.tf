locals {
  name = "Emiliano Frigo"
  age  = 36
  my_object = {
    key1 = 10
    key2 = "my_value"
  }
}

output "upper_example" {
  value = upper(local.name)
}

output "starswith_example" {
  value = startswith(lower(local.name), "john")
}

output "power_example" {
  value = pow(local.age, 2)
}

output "read_file_example" {
  value = yamldecode(file("${path.module}/users.yml")).users[*].name
}

output "yamlencode_example" {
  value = yamlencode(local.my_object)
}

output "jsonencode_example" {
  value = jsonencode(local.my_object)
}
