variable "cluster_name" {
  type = string
  default = "terraform-cluster"
}

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
  default = "terraform-node"
}

variable "image_type" {
  default = "COS_CONTAINERD"
}
