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

resource "google_cloudfunctions2_function" "function" {
  provider    = google-beta
  name        = "pubsub-producer"
  location    = var.region
  description = "Publish order event messages to Pub/sub"

  build_config {
    runtime     = "python310"
    entry_point = "pubsub_producer" # Set the entry point 
    source {
      storage_source {
        bucket = google_storage_bucket.cloud_functions.name
        object = google_storage_bucket_object.producer_code.name
      }
    }
  }

  service_config {
    max_instance_count = 3
    min_instance_count = 1
    available_memory   = "128Mi"
    timeout_seconds    = 60
    ingress_settings   = "ALLOW_ALL"
    environment_variables = {
      PROJECT_ID = var.project_id
    }
  }
}
