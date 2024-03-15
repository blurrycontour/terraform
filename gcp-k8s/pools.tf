resource "google_container_node_pool" "spot_medium_node_pool" {
  name       = "spot-medium-pool"
  cluster    = google_container_cluster.terraform_cluster.name
  location   = var.zone
  node_count = 2

  autoscaling {
    min_node_count = 0
    max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 30
    disk_type    = "pd-standard"
    image_type   = var.image_type
    tags         = [var.tag]
    labels = {
      preemptible-node = true
    }
  }
}

# resource "google_container_node_pool" "medium_node_pool" {
#   name       = "medium-pool"
#   cluster    = google_container_cluster.terraform_cluster.name
#   location = var.zone
#   node_count = 0

#   node_config {
#     preemptible  = false
#     machine_type = "e2-medium"
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#     disk_size_gb = 30
#     disk_type    = "pd-standard"
#     image_type   = var.image_type
#     tags         = [var.tag]
#   }
# }

resource "google_container_node_pool" "spot_standard_node_pool" {
  name       = "spot-standard-pool"
  cluster    = google_container_cluster.terraform_cluster.name
  location   = var.zone
  node_count = 2

  autoscaling {
    location_policy      = "BALANCED"
    total_min_node_count = 0
    total_max_node_count = 10
  }

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 50
    disk_type    = "pd-standard"
    image_type   = var.image_type
    tags         = [var.tag]
    labels = {
      preemptible-node = false
    }
  }
}
