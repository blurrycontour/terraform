resource "google_compute_network" "terraform_net" {
  name                    = "terraform-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform-subnet" {
  name          = "terraform-subnet"
  region        = var.region
  ip_cidr_range = "10.108.0.0/16"
  network       = google_compute_network.terraform_net.self_link
}

resource "google_compute_firewall" "allow_ssh" {
  name      = "allow-ssh"
  network   = google_compute_network.terraform_net.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22","80","443"]
  }

  allow {
    protocol = "icmp"
  }

  target_tags   = [var.tag]
  source_ranges = ["0.0.0.0/0"]
  priority      = 65000
}
