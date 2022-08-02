resource "google_cloud_scheduler_job" "producer" {
  name             = "pubsub-producer-job"
  description      = "Trigger the pubsub-producer function"
  schedule         = "* * * * *"
  time_zone        = "America/New_York"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = google_cloudfunctions_function.producer.https_trigger_url

    oidc_token {
      service_account_email = "${var.project_id}@appspot.gserviceaccount.com"
    }
  }
}
