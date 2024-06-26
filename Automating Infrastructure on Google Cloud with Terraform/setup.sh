#!/bin/bash

# GSP345
## Run in cloudshell

export ZONE=

export BUCKET_HUSTLER=


export INSTANCE_HUSTLER=


export VPC_HUSTLER=

### Type `yes` when asked

export REGION=${ZONE%-*}
export PROJECT_ID=$(gcloud config get-value project)
touch main.tf
touch variables.tf
mkdir -p modules/instances
cd modules/instances
touch instances.tf outputs.tf variables.tf

cd ..
mkdir storage
cd storage
touch storage.tf outputs.tf variables.tf
cd ~
echo 'variable "region" {
 default = "'"$REGION"'"
}

variable "zone" {
 default = "'"$ZONE"'"
}

variable "project_id" {
 default = "'"$PROJECT_ID"'"
}' > variables.tf

echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}' >main.tf

terraform init

echo 'resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard-1"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard-1"
  zone         =  "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}' > modules/instances/instances.tf
INSTANCE_ID1=$(gcloud compute instances describe tf-instance-1 --zone=$ZONE --format="value(id)")
INSTANCE_ID2=$(gcloud compute instances describe tf-instance-2 --zone=$ZONE --format="value(id)")
terraform import module.instances.google_compute_instance.tf-instance-1 $INSTANCE_ID1
terraform import module.instances.google_compute_instance.tf-instance-2 $INSTANCE_ID2
terraform plan
terraform apply -auto-approve
echo 'resource "google_storage_bucket" "storage-bucket" {
  name          = "'"$BUCKET_HUSTLER"'"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}' > modules/storage/storage.tf

echo 'terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}
module "storage" {
  source     = "./modules/storage"
}' > main.tf

terraform init
terraform apply -auto-approve

echo 'terraform {
  backend "gcs" {
    bucket  = "'"$BUCKET_HUSTLER"'"
 prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}
module "storage" {
  source     = "./modules/storage"
}' > main.tf
terraform init
echo 'resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard-1"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard-1"
  zone         =  "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}
resource "google_compute_instance" "'"$INSTANCE_HUSTLER"'" {
  name         = "'"$INSTANCE_HUSTLER"'"
  machine_type = "n1-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}' > modules/instances/instances.tf
terraform init
terraform apply -auto-approve
echo 'resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "e2-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "e2-standard-2"
  zone         =  "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}
resource "google_compute_instance" "'"$INSTANCE_HUSTLER"'" {
  name         = "'"$INSTANCE_HUSTLER"'"
  machine_type = "e2-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}' > modules/instances/instances.tf

terraform init
terraform apply -auto-approve
terraform taint module.instances.google_compute_instance.$INSTANCE_HUSTLER
terraform plan
terraform apply -auto-approve

echo 'resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "e2-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "e2-standard-2"
  zone         =  "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
 network = "default"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}' > modules/instances/instances.tf
terraform apply -auto-approve
echo 'terraform {
  backend "gcs" {
    bucket  = "'"$BUCKET_HUSTLER"'"
 prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}
module "storage" {
  source     = "./modules/storage"
}
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "'"$PROJECT_ID"'"
    network_name = "'"$VPC_HUSTLER"'"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "'"$REGION"'"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "'"$REGION"'"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
    ]
}' > main.tf

terraform init
terraform apply -auto-approve

echo 'resource "google_compute_instance" "tf-instance-1"{
  name         = "tf-instance-1"
  machine_type = "n1-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "'"$VPC_HUSTLER"'"
     subnetwork = "subnet-01"
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

resource "google_compute_instance" "tf-instance-2"{
  name         = "tf-instance-2"
  machine_type = "n1-standard-2"
  zone         = "'"$ZONE"'"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "'"$VPC_HUSTLER"'"
     subnetwork = "subnet-02"
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "'"$PROJECT_ID"'"
    network_name = "'"$VPC_HUSTLER"'"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "'"$REGION"'"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "'"$REGION"'"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
    ]
}' > modules/instances/instances.tf
terraform init
terraform apply -auto-approve

echo 'terraform {
  backend "gcs" {
    bucket  = "'"$BUCKET_HUSTLER"'"
 prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.53.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region

  zone        = var.zone
}

module "instances" {

  source     = "./modules/instances"

}
module "storage" {
  source     = "./modules/storage"
}
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "'"$PROJECT_ID"'"
    network_name = "'"$VPC_HUSTLER"'"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "'"$REGION"'"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "'"$REGION"'"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
    ]
}
resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
 network = "projects/'$PROJECT_ID'/global/networks/'$VPC_HUSTLER'"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}' > main.tf
terraform init
terraform apply -auto-approve
