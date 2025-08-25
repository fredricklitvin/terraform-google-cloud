# locals {
#   # Change this suffix to a new, unique value if you've tried v6 already
#   suffix = "v7"
# }

# # Define variables for your GitHub repository
# variable "github_repo_owner" {
#   description = "The owner of the GitHub repository."
#   type        = string
#   default     = "fredricklitvin"
# }

# variable "github_repo_name" {
#   description = "The name of the GitHub repository."
#   type        = string
#   default     = "k8s-project-helm"
# }


# resource "google_service_account" "github_actions" {
#   account_id   = "sgithub-actions-${local.suffix}"
#   display_name = "github actions Account ${local.suffix}"
# }

# resource "google_iam_workload_identity_pool" "github_actions_pool" {
#   workload_identity_pool_id = "github-actions-pool-${local.suffix}"
#   display_name              = "GitHub Actions Pool ${local.suffix}"
# }

# resource "google_iam_workload_identity_pool_provider" "github_provider" {
#   workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
#   workload_identity_pool_provider_id = "github-actions-provider-${local.suffix}"
#   display_name                     = "GitHub Actions Provider ${local.suffix}"

#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }

#   attribute_mapping = {
#     "google.subject"       = "assertion.sub"
#     "attribute.repository" = "assertion.repository"
#   }
# }

# data "google_iam_policy" "github_iam_policy" {
#   binding {
#     role = "roles/iam.workloadIdentityUser"
#     members = [
#       # **This is the key fix.** It explicitly constructs the URL,
#       # avoiding issues with the `name` attribute.
#       "principalSet://iam.googleapis.com/projects/${var.project}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id}/attribute.repository/${var.github_repo_owner}/${var.github_repo_name}",
#     ]
#   }
# }

# resource "google_service_account_iam_policy" "github_iam_policy_binding" {
#   service_account_id = google_service_account.github_actions.name
#   policy_data        = data.google_iam_policy.github_iam_policy.policy_data
# }

# resource "google_project_iam_member" "artifact_registry_writer" {
#   project = var.project
#   role    = "roles/artifactregistry.writer"
#   member  = "serviceAccount:${google_service_account.github_actions.email}"
# }