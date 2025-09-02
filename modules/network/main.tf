resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  }

resource "google_compute_subnetwork" "private_subnet" {
  name          = var.private_subnet_name
  ip_cidr_range = var.private_subnet_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  secondary_ip_range {
    range_name = "gke-pods"
    ip_cidr_range = var.private_subnet_cidr_range_pods
  }
    secondary_ip_range {
    range_name = "gke-services"
    ip_cidr_range = var.private_subnet_cidr_range_services
  }
  }

resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  ip_cidr_range = var.public_subnet_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  }

resource "google_compute_router" "router" {
  name = var.router_name
  region = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name = var.nat_name
  router = google_compute_router.router.name
  region = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
}
}
