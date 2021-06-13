variable "project_id" {
  type    = string
  default = "psychic-surf-316617"
}

variable "gcp_credentials_file" {
  type        = string
  description = "GCP credentials JSON file path. Set with \"TF_VAR_gcp_credentials_file\""
  sensitive   = true
}

variable "region" {
  type    = string
  default = "europe-central2"
}

variable "zone" {
  type    = string
  default = "europe-central2-c"
}

variable "vpc_name" {
  type = string
}

variable "machine_type" {
  type = string
}