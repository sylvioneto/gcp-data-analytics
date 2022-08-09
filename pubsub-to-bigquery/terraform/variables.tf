locals {
  resource_labels = {
    terraform = "true"
    app       = "pubsub-to-bigquery"
    purpose   = "demo"
    env       = "sandbox"
    repo      = "gcp-data-analytics"
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

variable "gcp_ingest_api_image" {
  description = "Container image to use on Cloud Run ingest API"
  default     = "us-central1-docker.pkg.dev/syl-data-analytics/docker-repo/gcp-ingest-api:3bb2827c-1681-4395-a14a-f1043630aefa"
}
