output "endpoint" {
  value = google_container_cluster.terraform_cluster.endpoint
}

# output "kubeconfig" {
#   value = google_container_cluster.terraform_cluster.master_auth[0].cluster_ca_certificate
# }
