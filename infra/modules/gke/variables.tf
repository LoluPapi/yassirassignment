variable "env" {
  description = "The environment for the GKE cluster"
}

variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "yassir-gke-network"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "yassir-gke-subnet"
}
variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}
variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone."
  type        = string
  default     = "europe-west1-b"
}
