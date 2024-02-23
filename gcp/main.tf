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
  machine_type              = "e2-micro"
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
}

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
