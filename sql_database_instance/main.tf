provider "google" {
  credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project     = "terraformpractical"
  //region      = "us-west1"

}

resource "google_project_service" "project" {
  project = "terraformpractical"
  count   = length(var.gcp_service_list)
  service = var.gcp_service_list[count.index]

  disable_dependent_services = true
}

resource "google_compute_network" "myvpc" {
  name                    = "myvpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.myvpc.name
}

resource "google_compute_firewall" "f1" {
  name    = "firewall"
  network = google_compute_network.myvpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "3306"]
  }

  //source_tags = ["web"]
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = "my-database-instance2"
  region = "us-central1"

  depends_on = [
    google_compute_network.myvpc,
    google_project_service.project
  ]

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.myvpc.id
    }
  }

  deletion_protection = "true"

}

output "v1" {
  value = length(var.gcp_service_list)
}

//Error, failed to create instance my-database-instance: googleapi: Error 409: The Cloud SQL instance already exists. 
//When you delete an instance, you can't reuse the name of the deleted instance until one week from the deletion date., instanceAlreadyExists
