terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.71.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.3.2"
    }
  }
}

# PROVIDERS

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

provider "kubernetes" {
  host                   = module.cluster.kubernetes_cluster_host
  token                  = data.google_client_config.defaults.access_token
  cluster_ca_certificate = base64decode(module.cluster.ca_certificate)
}

# DATA

data "google_client_config" "defaults" {}

# MODULES

module "network" {
  source          = "./modules/network"
  vpc_name        = var.vpc_name
  region          = var.region
  gke_subnet_cidr = var.gke_subnet_cidr
}

module "cluster" {
  source       = "./modules/cluster"
  env          = var.env
  project_id   = var.project_id
  region       = var.region
  vpc_network  = module.network.vpc_network_name
  vpc_subnet   = module.network.vpc_gke_subnet_name
  node_count   = var.gke_node_count
  machine_type = var.machine_type
}


module "deployments" {
  source = "./modules/deployments"
}



