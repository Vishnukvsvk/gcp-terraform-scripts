provider "google" {
  credentials = file("C:/Users/VISHNU/Documents/gcp_service_cred/terraformpractical-42041d202ffe.json")
  project     = "terraformpractical"
  //region      = "us-west1"

}


resource "google_storage_bucket" "backup" {
  name          = "backup-bucket-007890"
  location      = "US"
  storage_class = "NEARLINE"
  force_destroy = true
  retention_policy {
    is_locked        = true //You cant edit,update anything in bucket
    retention_period = 10   //in seconds (value of 1 hour) //You cant delete until retention period is over
  }
}


