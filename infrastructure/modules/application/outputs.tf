output "app_server_ip" {
  value = google_compute_instance.app_server.network_interface[0].network_ip
}