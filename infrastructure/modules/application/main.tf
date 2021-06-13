resource "google_compute_instance" "app_server" {
  machine_type = var.machine_type
  name         = "app-server"
  tags         = ["vm", "web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = var.network_name
    access_config {
    }
  }
}