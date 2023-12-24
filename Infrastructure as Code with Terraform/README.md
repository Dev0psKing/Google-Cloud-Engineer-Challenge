# Infrastructure as Code with Terraform

## Overview

Terraform, the infrastructure as code (IaC) tool from HashiCorp, empowers operators and infrastructure teams to build, change, and manage infrastructure in a safe and repeatable manner. Utilizing the HashiCorp Configuration Language (HCL), Terraform enables the creation of human-readable, automated deployments for environments across various providers, including AWS, Google Cloud, GitHub, Docker, and more.

IaC involves managing infrastructure through files rather than manual configuration, offering a structured approach to resource definition. Terraform simplifies this process, allowing operators to define desired resources and automate their creation using HCL.

## Simple Workflow for Deployment

Follow this straightforward workflow when deploying infrastructure with Terraform:

1. **Scope**: Identify and confirm the resources needed for a specific project.
2. **Author**: Create a configuration file in HCL based on the scoped parameters.
3. **Initialize**: Run `terraform init` in the project directory to download the correct provider plug-ins for the project.
4. **Plan & Apply**: Use `terraform plan` to verify the creation process and then `terraform apply` to create real resources along with the state file for future comparisons.

## What You'll Learn

In this lab, you will gain proficiency in the following tasks:

1. **Build, Change, and Destroy Infrastructure with Terraform**: Understand the core actions of creating, modifying, and removing infrastructure resources.

2. **Create Resource Dependencies with Terraform**: Learn how to establish dependencies between different resources for a more organized infrastructure.

3. **Provision Infrastructure with Terraform**: Explore the process of provisioning infrastructure resources using Terraform.

## My Solution

To get started, execute the following commands in your terminal:

```bash
export PROJECT_ID=$(gcloud config get-value project)

# Creating a basic network resource
echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "'"$PROJECT_ID"'"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}' > main.tf

# Initializing and applying the basic network resource
terraform init
terraform apply -auto-approve

# Expanding the configuration to include a virtual machine instance
echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "'"$PROJECT_ID"'"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}' > main.tf

# Applying the updated configuration with a virtual machine instance
terraform apply -auto-approve

# Enhancing the configuration with tags and a different image for the virtual machine
echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "'"$PROJECT_ID"'"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags        = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}' > main.tf

# Applying the enhanced configuration
terraform apply -auto-approve

# Further expanding the configuration to include a static IP and a storage bucket
echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "'"$PROJECT_ID"'"
  region  = "us-central1"
  zone    = "us-central1-c"
}
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  tags        = ["web", "dev"]
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}
resource "google_storage_bucket" "example_bucket" {
  name     = "'"$PROJECT_ID"'"
  location = "US"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
resource "google_compute_instance" "another_instance" {
  depends_on = [google_storage_bucket.example_bucket]
  name         = "terraform-instance-2"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}' > main.tf

# Running a plan and applying the expanded configuration
terraform plan
terraform apply -auto-approve
```

This script guides you through the process of progressively building and expanding your infrastructure using Terraform. Feel free to reach out if you have any questions or encounter issues during the process. Happy Terraforming!