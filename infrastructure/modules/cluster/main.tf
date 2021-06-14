resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke-${var.env}"
  location = var.region

  # just to stay a bit longer in the free tier..
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_network
  subnetwork = var.vpc_subnet
}

resource "google_container_node_pool" "gke_node_pool" {
  cluster    = google_container_cluster.primary.name
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  node_count = var.node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env     = var.env
      project = var.project_id
    }

    machine_type = var.machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

