resource "google_cloud_run_v2_service" "nodejs_api" {

  name                = var.cloud_run_service_name
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {

    service_account = google_service_account.cloudrun_sa.email

    timeout = "300s"

    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }

    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "PRIVATE_RANGES_ONLY"
    }

    containers {

      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.artifact_repo_name}/nodejs-api:v1"

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "DB_HOST"
        value = google_sql_database_instance.mysql.private_ip_address
      }

      env {
        name  = "DB_USER"
        value = var.db_user
      }

      env {
        name  = "DB_NAME"
        value = var.db_name
      }

      env {
        name  = "DB_PORT"
        value = "3306"
      }

      env {
        name = "DB_PASSWORD"

        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.db_password.secret_id
            version = "latest"
          }
        }
      }

      startup_probe {
        timeout_seconds   = 10
        period_seconds    = 30
        failure_threshold = 3

        tcp_socket {
          port = 8080
        }
      }
    }
  }

  depends_on = [
    google_artifact_registry_repository.docker_repo,
    google_vpc_access_connector.connector,
    google_sql_database_instance.mysql
  ]
}