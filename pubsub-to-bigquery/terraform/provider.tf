terraform {
  backend "gcs" {
  }

  required_providers {
    google = {
      version = "~> 4.31"
    }
    google-beta = {
      version = "~> 4.31"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
