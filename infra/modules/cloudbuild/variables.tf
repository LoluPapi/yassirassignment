
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

variable "env" {
  description = "Environment"
  type        = string
}