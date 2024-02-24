variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "instance_type" {
  default = "e2-micro"
}

variable "project" {
  default = "terraform-gcp-415220"
}

variable "credentials_file" {}

variable "tag" {
  default = "terraform-vm"
}

variable "ssh_user" {
  default = "remote-user"
}

variable "ssh_pub_key_file" {}

variable "os_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}
