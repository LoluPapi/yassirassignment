# ---------------------------------------------------------------------------------------------------------------------
# CREATE A CLOUD BUILD TRIGGER
# ---------------------------------------------------------------------------------------------------------------------

resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  provider    = "google-beta"
  description = "Cloud Source Repository Trigger yassirrepo ${var.env}"
  project     = "yassir-code-challenge"


  trigger_template {
    branch_name = "master"
    repo_name   = "yassirrepo"
  }

  substitutions = {
    _GCR_REGION           = var.region
    _GKE_CLUSTER_LOCATION = "europe-west1"
    _GKE_CLUSTER_NAME     = "yassir-code-challenge-gke-${var.env}"
  }
 
  filename = "/cloudbuild.yaml"
    
}