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

module "name" {
  source = "./modules/network"
}

