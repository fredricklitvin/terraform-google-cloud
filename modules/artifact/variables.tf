variable "project" {
  description = "The GCP project being used"
  type = string
  sensitive   = true
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}


variable "project_suffix" {
  type        = string
  description = "A unique suffix for resources to prevent naming conflicts"
  default     = "v9"
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
