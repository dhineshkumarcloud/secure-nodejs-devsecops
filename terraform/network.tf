resource "google_compute_network" "main" {
  name                    = "secure-vpc"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "main" {
  name          = "secure-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}
resource "google_compute_global_address" "private_ip" {

  name = "private-ip"

  purpose = "VPC_PEERING"

  address_type = "INTERNAL"

  prefix_length = 16

  network = google_compute_network.main.id
}
resource "google_service_networking_connection" "private_vpc_connection" {

  network = google_compute_network.main.id

  service = "servicenetworking.googleapis.com"

  reserved_peering_ranges = [
    google_compute_global_address.private_ip.name
  ]
}
resource "google_compute_firewall" "allow_internal" {

  name = "allow-internal"

  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
  }

  source_ranges = [
    "10.10.0.0/24"
  ]
}
resource "google_vpc_access_connector" "connector" {
  name          = "cloudrun-connector"
  region        = var.region
  network       = google_compute_network.main.name
  ip_cidr_range = "10.8.0.0/28"

  machine_type = "e2-micro"

  min_instances = 2
  max_instances = 3
}