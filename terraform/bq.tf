resource "google_bigquery_dataset" "raw" {
  dataset_id  = "ecommerce_raw"
  description = "Store raw data ingested through Pub/sub"
  location    = var.region
  labels      = local.resource_labels
}

resource "google_bigquery_table" "raw_order_events" {
  dataset_id          = google_bigquery_dataset.raw.dataset_id
  table_id            = "order_events"
  description         = "Store events streamed from order-events-to-bigquery subscription"
  deletion_protection = false

  time_partitioning {
    type  = "DAY"
    field = "publish_time"
  }

  labels = local.resource_labels

  schema = <<EOF
[
  {
    "name": "subscription_name",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "message_id",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "publish_time",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "data",
    "type": "STRING",
    "mode": "NULLABLE"
  },
    {
    "name": "attributes",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF

}
