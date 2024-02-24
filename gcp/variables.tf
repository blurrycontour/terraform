variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
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
