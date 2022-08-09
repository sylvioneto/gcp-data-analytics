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
  default     = "us-central1-docker.pkg.dev/syl-data-analytics/docker-repo/gcp-ingest-api:dbc21f5d-5c75-4128-b379-d4239ff59e29"
}
