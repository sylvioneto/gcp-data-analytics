resource "google_bigquery_dataset" "raw_dataset" {
  dataset_id  = "ecommerce_raw"
  description = "Store raw data ingested through Pub/sub"
  location    = var.region
  labels      = local.resource_labels

  access {
    role          = "WRITER"
    user_by_email = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  }

  access {
    role          = "READER"
    user_by_email = google_service_account.composer_sa.email
  }
}
