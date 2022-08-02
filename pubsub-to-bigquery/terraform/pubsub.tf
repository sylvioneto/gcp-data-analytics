resource "google_pubsub_topic" "order_ingest" {
  name   = "ingest-order-events"
  labels = local.resource_labels
}

# waiting for release 4.32 https://github.com/hashicorp/terraform-provider-google-beta/tags
# resource "google_pubsub_subscription" "order_to_bq_sub" {
#   provider = google-beta
#   name     = "order-events-to-bigquery"
#   topic    = google_pubsub_topic.order_ingest.name
#   labels   = local.resource_labels

#   bigquery_config {
#     table          = google_bigquery_table.raw_order_events.id
#     write_metadata = true
#   }
# }

