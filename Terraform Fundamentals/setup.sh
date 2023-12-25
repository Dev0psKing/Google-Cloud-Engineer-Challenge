# This is the build infractructure for the terraform project

resource "google_compute_instance" "terraform" {
  project      = ""
  name         = "terraform"
  machine_type = "e2-medium"
  zone         = ""

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}