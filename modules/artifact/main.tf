# A local variable for a suffix, but we can also make this a variable
locals {
  suffix = var.project_suffix
}

# 1. Resource that creates an Artifact Registry repository
resource "google_artifact_registry_repository" "backend" {
  location      = var.region
  repository_id = var.artifact_repository_name
  format        = "DOCKER"
}

# 2. Resources for Workload Identity Federation (WIF)
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

  # Make the GitHub repository a variable
  attribute_condition = "attribute.repository == '${var.github_repository}'"
}

data "google_iam_policy" "github_iam_policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/attribute.repository/${var.github_repository}",
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

# 3. Granting permissions to push to the registry
resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}
