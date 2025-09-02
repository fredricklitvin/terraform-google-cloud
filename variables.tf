variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "project" {
  description = "The GCP project being used"
  type = string
  sensitive   = true
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

variable "public_subnet_name" {
  description = "The name of the public subnet "
  type        = string
  default     = "public-subnet"
}
