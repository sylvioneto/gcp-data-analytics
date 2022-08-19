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
  default     = "us-central1-docker.pkg.dev/syl-data-analytics/docker-repo/gcp-ingest-api:9b6149a6-1623-4cb8-920f-31d4630d0e52"
}
