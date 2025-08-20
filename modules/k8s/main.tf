resource "google_container_cluster" "default" {
  name = "k8s"

  location                 = "us-central1"
  enable_autopilot         = true
  enable_l4_ilb_subsetting = true

  network    = var.vpc_network_id
  subnetwork = var.private_subnet_id

  ip_allocation_policy {
    stack_type                    = "IPV4"
    services_secondary_range_name = var.secondary_ip_range_1
    cluster_secondary_range_name  = var.secondary_ip_range_0
  }

  deletion_protection = false
}