output "vpc_network_name" {
  value       = google_compute_network.vpc_network.name
  description = "VPC network name"
}

output "vpc_gke_subnet_name" {
  value       = google_compute_subnetwork.gke_subnet.name
  description = "VPC GKE subnet name"
}
