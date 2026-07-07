resource "google_service_account" "cloudrun_sa" {

  account_id = "cloudrun-sa"

  display_name = "Cloud Run Service Account"
}
resource "google_project_iam_member" "cloudsql_client" {

  project = var.project_id

  role = "roles/cloudsql.client"

  member = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
resource "google_project_iam_member" "secret_accessor" {

  project = var.project_id

  role = "roles/secretmanager.secretAccessor"

  member = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
resource "google_project_iam_member" "artifact_reader" {

  project = var.project_id

  role = "roles/artifactregistry.reader"

  member = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
resource "google_project_iam_member" "logging_writer" {

  project = var.project_id

  role = "roles/logging.logWriter"

  member = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
resource "google_project_iam_member" "monitoring_writer" {

  project = var.project_id

  role = "roles/monitoring.metricWriter"

  member = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}