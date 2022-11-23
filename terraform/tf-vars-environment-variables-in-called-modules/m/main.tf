variable "b" {
  type    = string
  default = "default value of b"
}

output "b" {
  value = var.b
}
