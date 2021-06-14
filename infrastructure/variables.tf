variable "project_id" {
  type    = string
  default = "psychic-surf-316617"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "gcp_credentials_file" {
  type        = string
  description = "GCP credentials JSON file path. Set with \"TF_VAR_gcp_credentials_file\""
  sensitive   = true
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-c"
}

variable "vpc_name" {
  type = string
}

variable "gke_subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "gke_node_count" {
  type    = number
  default = 1
}

variable "machine_type" {
  type = string
}