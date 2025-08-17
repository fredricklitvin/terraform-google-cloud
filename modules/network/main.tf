resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
  }

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.1.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
  secondary_ip_range {
    range_name = "gke-pods"
    ip_cidr_range = "10.3.0.0/16"
  }
    secondary_ip_range {
    range_name = "gke-services"
    ip_cidr_range = "10.4.0.0/16"
  }
  }

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
  }

resource "google_compute_router" "router" {
  name = "vpc-router"
  region = "us-central1"
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name = "nat"
  router = google_compute_router.router.name
  region = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
}
}
