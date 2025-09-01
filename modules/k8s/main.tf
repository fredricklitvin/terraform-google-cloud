resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}
resource "google_project_iam_member" "artifact_registry_reader_role" {
  project = var.project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}
resource "google_project_iam_member" "compute_storage_admin_role" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_container_cluster" "default" {
  name = "k8s"

  location = "us-central1"
  
  # Switch to a Standard cluster
  enable_autopilot = false
  
  # This block is now valid for a Standard cluster
  node_config {
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  initial_node_count = 1 # Start with a single node
  
  # The following arguments are not compatible with a standard cluster
  # and should be removed if they are present:
  # enable_l4_ilb_subsetting = true
  deletion_protection = false
  network    = var.vpc_network_id
  subnetwork = var.private_subnet_id

  ip_allocation_policy {
    stack_type                    = "IPV4"
    services_secondary_range_name = var.secondary_ip_range_1
    cluster_secondary_range_name  = var.secondary_ip_range_0
  }
}

resource "google_compute_disk" "app_data_disk" {
  name    = "app-data-disk"
  project = var.project
  zone    = "us-central1-a" 
  size    = 10             
  type    = "pd-standard"
}

