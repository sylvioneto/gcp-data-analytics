resource "google_cloud_run_service" "default" {
  name     = "order-event-ingest-api"
  location = var.region
  template {
    spec {
      containers {
        image = "us-central1-docker.pkg.dev/syl-data-analytics/docker-repo/gcp-ingest-api:39b804c3-6507-4c26-ab48-1a4562998cb8"
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
