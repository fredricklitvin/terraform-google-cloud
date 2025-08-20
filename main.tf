terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.44.0"
    }
  }
  backend "gcs" {
    bucket  = "terraform-state-fred"
    prefix  = "terraform/state"
  }
}

module "network" {
  source = "./modules/network"
}

module "k8s" {
  source = "./modules/k8s"
  vpc_network_id = module.network.vpc_network_id
  private_subnet_id = module.network.private_subnet_id
  secondary_ip_range_1 = module.network.private_subnet_ip_range_1
  secondary_ip_range_0 = module.network.private_subnet_ip_range_0
}
