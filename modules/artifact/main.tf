resource "google_artifact_registry_repository" "main_app_image" {
  location      = "us-central1"
  repository_id = "main_app_image"
  description   = "main app  docker repository"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "database_app_image" {
  location      = "us-central1"
  repository_id = "database_app_image"
  description   = "database app  docker repository"
  format        = "DOCKER"
}