resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "vpc_default_firewall" {
  name    = "default-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "TCP"
    ports    = [22, 80]
  }
}

resource "google_compute_subnetwork" "gke_subnet" {
  ip_cidr_range = var.gke_subnet_cidr
  name          = "gke-subnet"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}