provider "google" {
  project = "cellular-cider-339905"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "satya.json"
}

resource "google_compute_instance" "vm_instance" {
  name         = "satya-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220331"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "satya-network"
  auto_create_subnetworks = "true"
}
// VPC firewall configuration
resource "google_compute_firewall" "demo-firewall" {
  name    = "satya_firewall"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "1000-2000"]
    
  }

  source_ranges = ["0.0.0.0/0"]
}

