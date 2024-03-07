terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.17.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

# Create the Kubernetes cluster
resource "google_container_cluster" "terraform_cluster" {
  name     = var.cluster_name
  location = var.zone

  initial_node_count       = 1
  remove_default_node_pool = true

  network = google_compute_network.terraform_net.self_link
  subnetwork = google_compute_subnetwork.terraform_subnet.self_link

  deletion_protection = false
}
