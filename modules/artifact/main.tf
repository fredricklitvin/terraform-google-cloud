locals {
  suffix = "v9"
}
resource "google_artifact_registry_repository" "frontend" {
  location      = "us-central1"
  repository_id = "frontend"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "backend" {
  location      = "us-central1"
  repository_id = "backend"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "database" {
  location      = "us-central1"
  repository_id = "database"
  description   = "example docker repository"
  format        = "DOCKER"
}

resource "google_service_account" "github_actions" {
  account_id   = "sgithub-actions-${local.suffix}"
  display_name = "github actions Account ${local.suffix}"
}

resource "google_iam_workload_identity_pool" "github_actions_pool" {
  workload_identity_pool_id = "github-actions-pool-${local.suffix}"
  display_name              = "GitHub Actions Pool ${local.suffix}"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider-${local.suffix}"
  display_name                     = "GitHub Actions Provider ${local.suffix}"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
  }

  attribute_condition = "attribute.repository == 'fredricklitvin/k8s-project-helm'"
}

data "google_iam_policy" "github_iam_policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/attribute.repository/fredricklitvin/k8s-project-helm",
    ]
  }
  depends_on = [
    google_iam_workload_identity_pool_provider.github_provider,
  ]
}

resource "google_service_account_iam_policy" "github_iam_policy_binding" {
  service_account_id = google_service_account.github_actions.name
  policy_data        = data.google_iam_policy.github_iam_policy.policy_data
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}