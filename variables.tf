variable "region" {
  description = "The GCP region"
  type        = string
  default     = "me-west1"
}

variable "project" {
  description = "The GCP project being used"
  type = string
  sensitive   = true
}
