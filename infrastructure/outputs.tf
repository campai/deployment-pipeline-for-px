output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.cluster.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.cluster.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "vpc_network_name" {
  value       = module.network.vpc_network_name
  description = "VPC network name"
}

output "vpc_gke_subnet_name" {
  value       = module.network.vpc_gke_subnet_name
  description = "GKE subnet name"
}

output "lb_ip" {
  value = module.deployments.lb_ip
}
