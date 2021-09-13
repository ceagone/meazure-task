provider "google" {
  project = var.project_id
  credentials = file(var.google_credentials)
  region  = var.region
}

terraform {
  required_version = ">= 0.12.0"
}