locals {
    double_numbers = [ for nbr in var.numbers_list : nbr * 2 ]
}

output "double_numbers" {
    value = local.double_numbers
}