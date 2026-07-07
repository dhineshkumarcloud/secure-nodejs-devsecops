variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Deployment Region"
  type        = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "cloud_run_service_name" {
  type = string
}

variable "artifact_repo_name" {
  type = string
}
variable "notification_channel_id" {
  description = "Cloud Monitoring notification channel ID"
  type        = string
}