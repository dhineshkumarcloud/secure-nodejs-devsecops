output "db_password" {
  value     = random_password.db_password.result
  sensitive = true
}
output "cloud_sql_private_ip" {
  value = google_sql_database_instance.mysql.private_ip_address
}
output "cloud_run_url" {
  value = google_cloud_run_v2_service.nodejs_api.uri
}