resource "google_bigquery_dataset" "stag_dataset" {
  dataset_id  = "ecommerce_staging"
  description = "Staging area for transformations"
  location    = var.region
  labels      = local.resource_labels
}

resource "google_bigquery_table" "stag_order_events" {
  dataset_id          = google_bigquery_dataset.stag_dataset.dataset_id
  table_id            = "order_events"
  description         = "Staging table for order events"
  deletion_protection = false

  time_partitioning {
    type  = "DAY"
    field = "action_time"
  }

  labels = local.resource_labels

  schema = <<EOF
[
  {
    "name": "order_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Order ID from the source system"
  },
  {
    "name": "customer_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Customer ID from the source system"
  },
  {
    "name": "action",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The action performed by the user"
  },
  {
    "name": "action_time",
    "type": "TIMESTAMP",
    "mode": "NULLABLE",
    "description": "Time when the action ocurred"
  },
  {
    "name": "message_key",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Message key for data pipelines controls"
  }
]
EOF

}
