resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
}
resource "google_compute_firewall" "vpc_default_firewall" {
  name    = "default-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "TCP"
    ports    = [22]
  }
}