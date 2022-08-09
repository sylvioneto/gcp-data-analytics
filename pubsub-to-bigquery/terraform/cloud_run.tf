resource "google_cloud_run_service" "default" {
  name     = "order-event-ingest-api"
  location = var.region
  metadata {
    labels = local.resource_labels
    annotations = {
      "autoscaling.knative.dev/minScale" = "1"
      "autoscaling.knative.dev/maxScale" = "10"
    }
  }
  template {
    spec {
      containers {
        image = var.gcp_ingest_api_image
        env {
          name  = "PROJECT_ID"
          value = var.project_id
        }
        env {
          name  = "TOPIC_ID"
          value = google_pubsub_topic.order_ingest.name
        }
        env {
          name  = "SOURCE_SYSTEM"
          value = "order-management"
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
