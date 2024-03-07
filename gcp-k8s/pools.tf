# resource "google_container_node_pool" "micro_node_pool" {
#   name       = "micro-pool"
#   cluster    = google_container_cluster.terraform_cluster.name
#   location = var.zone
#   node_count = 3

#   node_config {
#     preemptible  = false
#     machine_type = "e2-micro"
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#     disk_size_gb = 30
#     disk_type    = "pd-standard"
#     image_type   = var.image_type
#     tags         = [var.tag]
#   }
# }

resource "google_container_node_pool" "medium_node_pool" {
  name       = "medium-pool"
  cluster    = google_container_cluster.terraform_cluster.name
  location = var.zone
  node_count = 4

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 40
    disk_type    = "pd-balanced"
    image_type   = var.image_type
    tags         = [var.tag]
  }
}

resource "google_container_node_pool" "standard_node_pool" {
  name       = "standard-pool"
  cluster    = google_container_cluster.terraform_cluster.name
  location = var.zone
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 50
    disk_type    = "pd-balanced"
    image_type   = var.image_type
    tags         = [var.tag]
  }
}
