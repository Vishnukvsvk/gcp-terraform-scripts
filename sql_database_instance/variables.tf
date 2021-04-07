variable "gcp_service_list" {
  description = "List of GCP service to be enabled for a project."
  type        = list
  default = [
              "cloudresourcemanager.googleapis.com", 
              "sqladmin.googleapis.com"
            ]
}
