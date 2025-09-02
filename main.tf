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
  region = var.region
  vpc_name = var.vpc_name
  private_subnet_name = var.private_subnet_name
  public_subnet_name = var.public_subnet_name
}

module "k8s" {
  source = "./modules/k8s"
  project = var.project
  vpc_network_id = module.network.vpc_network_id
  private_subnet_id = module.network.private_subnet_id
  secondary_ip_range_1 = module.network.private_subnet_ip_range_1
  secondary_ip_range_0 = module.network.private_subnet_ip_range_0
  service_account_id = var.service_account_id
  service_account_display_name = var.service_account_display_name
  cluster_name = var.cluster_name
  disk_name = var.disk_name
  region = var.region
}

module "artifact" {
  source = "./modules/artifact"
  project = var.project
  project_suffix = var.project_suffix
  artifact_repository_name = var.artifact_repository_name
  github_repository = var.github_repository
  region = var.region
}
