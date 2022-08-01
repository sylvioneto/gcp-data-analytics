resource "google_bigquery_dataset" "stag_dataset" {
  dataset_id  = "ecommerce_staging"
  description = "Staging area for transformations"
  location    = var.region
  labels      = local.resource_labels

  access {
    role          = "WRITER"
    user_by_email = google_service_account.composer_sa.email
  }
}

