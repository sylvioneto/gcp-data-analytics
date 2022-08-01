locals {
  composer_env_name = "composer-airflow-2"
  resource_labels = {
    terraform = "true"
    app       = "pubsub-to-bigquery"
    purpose   = "demo"
    env       = "sandbox"
    repo      = "gcp-data-analytics"
  }

  service_account = {
    email  = google_service_account.composer_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  ip_ranges = {
    pods     = "10.0.0.0/22"
    services = "10.0.4.0/24"
    nodes    = "10.0.6.0/24"
    master   = "10.0.7.0/28"
  }
}

variable "project_id" {
  description = "GCP Project ID"
  default     = null
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "us-east1"
}
