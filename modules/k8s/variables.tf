variable "secondary_ip_range_1" {
  description = "services ip range"
  type        = string
}
variable "secondary_ip_range_0" {
  description = "pods ip range"
  type        = string
}
variable "vpc_network_id" {
  description = "vpc network id"
  type        = string
}
variable "private_subnet_id" {
  description = "private subnet  id"
  type        = string
}