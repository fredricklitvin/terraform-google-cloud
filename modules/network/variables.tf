variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the vpc "
  type        = string
  default     = "vpc-network"
}

variable "private_subnet_name" {
  description = "The name of the private subnet "
  type        = string
  default     = "private-subnet"
}

variable "private_subnet_cidr_range" {
  description = "The ip cidr range of the private subnet "
  type        = string
  default     = "10.1.0.0/16"
}

variable "private_subnet_cidr_range_pods" {
  description = "The ip cidr range of the private subnet pods for k8s "
  type        = string
  default     = "10.3.0.0/16"
}

variable "private_subnet_cidr_range_services" {
  description = "The ip cidr range of the private subnet services for k8s "
  type        = string
  default     = "10.4.0.0/16"
}


variable "public_subnet_name" {
  description = "The name of the public subnet "
  type        = string
  default     = "public-subnet"
}

variable "public_subnet_cidr_range" {
  description = "The ip cidr range of the public subnet "
  type        = string
  default     = "10.2.0.0/16"
}

variable "router_name" {
  description = "The name of the router "
  type        = string
  default     = "vpc-router"
}

variable "nat_name" {
  description = "The name of the nat "
  type        = string
  default     = "nat"
}