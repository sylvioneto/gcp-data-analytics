
module "composer" {
  source  = "terraform-google-modules/composer/google//modules/create_environment_v2"
  version = "~> 3.1"

  project_id               = var.project_id
  composer_env_name        = local.composer_env_name
  composer_service_account = google_service_account.composer_sa.email
  region                   = var.region
  image_version            = "composer-2.0.18-airflow-2.2.5"
  environment_size         = "ENVIRONMENT_SIZE_SMALL"

  network                          = module.vpc.network_name
  subnetwork                       = local.composer_env_name
  master_ipv4_cidr                 = local.ip_ranges.master
  service_ip_allocation_range_name = "services"
  pod_ip_allocation_range_name     = "pods"
  enable_private_endpoint          = true
  labels                           = local.resource_labels

  pypi_packages = {
    "apache-airflow-providers-microsoft-mssql" : ">=3.0.0"
    "apache-airflow-providers-google" : "==8.1.0"
  }

  depends_on = [
    module.vpc
  ]
}


# Service Account creation
resource "google_service_account" "composer_sa" {
  account_id   = local.composer_env_name
  display_name = "Service Account for instances of ${local.composer_env_name}"
}

# Required permissions for env provisioning
# Ref: https://cloud.google.com/composer/docs/troubleshooting-environment-creation
resource "google_project_iam_member" "composer_v2_extension" {
  project = var.project_id
  role    = "roles/composer.ServiceAgentV2Ext"
  member  = "serviceAccount:service-${data.google_project.project.number}@cloudcomposer-accounts.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "composer_worker" {
  project = var.project_id
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

resource "google_project_iam_member" "composer_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

# Required for managing data
resource "google_project_iam_member" "bq_admin" {
  project = var.project_id
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

resource "google_project_iam_member" "dataproc_admin" {
  project = var.project_id
  role    = "roles/dataproc.admin"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

