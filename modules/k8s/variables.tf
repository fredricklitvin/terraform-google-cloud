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

variable "project" {
  description = "The GCP project being used"
  type = string
  sensitive   = true
}

variable "region" {
  description = "The GCP region for the GKE cluster."
  type        = string
  default     = "us-central1"
}

variable "service_account_id" {
  description = "The ID of the GKE node service account."
  type        = string
  default     = "gke-node-sa"
}

variable "service_account_display_name" {
  description = "The display name for the GKE node service account."
  type        = string
  default     = "GKE Node Service Account"
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "k8s"
}

variable "node_count" {
  description = "The initial number of nodes in the GKE cluster."
  type        = number
  default     = 1
}

variable "disk_name" {
  description = "The name of the persistent disk."
  type        = string
  default     = "app-data-disk"
}

variable "disk_zone" {
  description = "The zone where the persistent disk will be created."
  type        = string
  default     = "us-central1-a"
}

variable "disk_size" {
  description = "The size of the persistent disk in GB."
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The type of the persistent disk."
  type        = string
  default     = "pd-standard"
}
