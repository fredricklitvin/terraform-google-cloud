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

#network mudule
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

#aritfact module
variable "project_suffix" {
  type        = string
  description = "A unique suffix for resources to prevent naming conflicts"
  default     = "v10"
}


variable "artifact_repository_name" {
  type        = string
  description = "The name of the Artifact Registry repository"
  default     = "backend"
}


variable "github_repository" {
  type        = string
  description = "The GitHub repository in 'owner/repo' format"
}

#k8s module
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

variable "disk_name" {
  description = "The name of the persistent disk."
  type        = string
  default     = "app-data-disk"
}