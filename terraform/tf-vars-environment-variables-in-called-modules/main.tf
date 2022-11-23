terraform {
}

variable "a" {
  type = string
}

variable "b" {
  type = string
}

module "m" {
  source = "./m/"
}

output "a_from_root" {
  value = var.a
}

output "b_from_root" {
  value = var.b
}

output "b_from_child" {
  value = module.m.b
}
