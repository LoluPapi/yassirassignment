terraform {
  backend "gcs" {
    bucket  = "lolutfbackend"
    prefix  = "state/bootstrap"
  }  
  required_version = ">= 0.12.7"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "3.82.0"
    }
  google-beta = {
  source = "hashicorp/google-beta"
   }
  }
}
provider "google" {
  project = "yassir-code-challenge"
  region  = "europe-west1"
  credentials = "${file("../../iac/creds.json")}"
}