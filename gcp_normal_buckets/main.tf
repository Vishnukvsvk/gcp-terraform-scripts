provider "google" {
  credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project     = "terraformpractical"
  //region      = "us-west1"

}


resource "google_storage_bucket" "normal" {
  name          = "normal-bucket-007890"
  location      = "US"
  storage_class = "STANDARD"
  force_destroy = false //Doesnt delete when files are present in bucket

}


