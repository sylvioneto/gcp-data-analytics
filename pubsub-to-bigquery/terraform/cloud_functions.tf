resource "google_storage_bucket" "cloud_functions" {
  name                        = "${var.project_id}-cloud-functions"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
  labels                      = local.resource_labels
}

resource "google_storage_bucket_object" "producer_code" {
  name   = "producer_code.zip"
  bucket = google_storage_bucket.cloud_functions.name
  source = "/workspace/producer_code.zip"
}

resource "google_cloudfunctions_function" "producer" {
  name        = "pubsub-producer"
  description = "Trigger pubsub_producer function"
  runtime     = "python310"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.cloud_functions.name
  source_archive_object = google_storage_bucket_object.producer_code.name
  trigger_http          = true
  entry_point           = "pubsub_producer"
  ingress_settings      = "ALLOW_ALL"
  labels                = local.resource_labels

  environment_variables = {
    PROJECT_ID = var.project_id
  }
}
