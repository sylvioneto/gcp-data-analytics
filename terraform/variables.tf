locals {
  resource_labels = {
    terraform = "true"
    app       = "ingest-api"
    env       = "sandbox"
    repo      = "gcp-streaming-data"
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
  default     = "us-central1-docker.pkg.dev/syl-data-analytics/docker-repo/gcp-ingest-api:b8b0b6fd-d7f6-48c3-9cab-bae67d91e472"
}
