resource "random_password" "db_password" {
  length  = 20
  special = true
}

resource "google_sql_database_instance" "mysql" {
  name             = "nodejs-mysql"
  database_version = "MYSQL_8_0"
  region           = var.region

  deletion_protection = false

  settings {
    tier              = "db-custom-1-3840"
    availability_type = "ZONAL"
    disk_size         = 20
    disk_type         = "PD_SSD"

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.main.id
    }

    backup_configuration {
      enabled = true
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "google_sql_database" "appdb" {
  name     = var.db_name
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "appuser" {
  name     = var.db_user
  instance = google_sql_database_instance.mysql.name
  password = random_password.db_password.result
}