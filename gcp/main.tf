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

resource "google_compute_disk" "default_boot_disk" {
  name  = "default-boot-disk"
  size  = 10
  type  = "pd-balanced"
  image = "ubuntu-os-cloud/ubuntu-2204-lts"
}

resource "google_compute_instance" "terraform_instance" {
  name                      = "terraform-instance"
  machine_type              = var.instance_type
  zone                      = var.zone
  allow_stopping_for_update = true

  boot_disk {
    source = google_compute_disk.default_boot_disk.name
  }

  network_interface {
    network    = google_compute_network.terraform_net.self_link
    subnetwork = google_compute_subnetwork.terraform-subnet.self_link
    access_config {
      // necessary even empty
    }
  }

  tags = [var.tag]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}
