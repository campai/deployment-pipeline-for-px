terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.71.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "network" {
  source   = "./modules/network"
  vpc_name = var.vpc_name
}

module "application" {
  source       = "./modules/application"
  network_name = module.network.vpc_network_name
  machine_type = var.machine_type
}



