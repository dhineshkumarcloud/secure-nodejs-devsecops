resource "google_artifact_registry_repository" "docker_repo" {

  location = var.region

  repository_id = var.artifact_repo_name

  description = "Docker images for Cloud Run"

  format = "DOCKER"
}