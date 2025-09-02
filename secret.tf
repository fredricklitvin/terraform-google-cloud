data "google_secret_manager_secret_version" "project_id" {
  secret = "project"
}


data "google_secret_manager_secret_version" "github_repository" {
  secret = "github_repository"
}


locals {
  project_id = data.google_secret_manager_secret_version.project_id.secret_data
  github_repository = data.google_secret_manager_secret_version.github_repository.secret_data
}
