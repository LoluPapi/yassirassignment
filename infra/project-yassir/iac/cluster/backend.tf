terraform {
  backend "gcs" {
    bucket  = "lolutfbackend"
    prefix  = "state/cluster"
  }  
  required_version = ">= 0.12.7"  
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = ">=3.82.0"
    }
    google-beta = {
     source = "hashicorp/google-beta"
   }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
    random = {
      source = "hashicorp/random"
      version = "3.2.0"
    }
  }
}

provider "google" {
  project = "yassir-code-challenge"
  region  = "europe-west1"
  credentials =  "${file("../../iac/creds.json")}"
}