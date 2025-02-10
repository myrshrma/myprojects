provider "google" {
  credentials = "${file("name of the credential file stored repo")}"  
  project     = "trans-filament-450510-v8"                       
  region      = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-central1"

  node_pool {
    name       = "default-pool"
    node_count = 1

    node_config {
      machine_type = "e2-medium"  
      preemptible  = true 
      disk_type    = "pd-standard"
      disk_size_gb = 30	  
    }
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}
