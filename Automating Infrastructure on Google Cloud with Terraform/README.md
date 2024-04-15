# Automating Infrastructure on Google Cloud with Terraform


## Overview

Welcome to the challenge lab for "Automating Infrastructure on Google Cloud with Terraform." In this lab, you will leverage your Terraform skills to create, deploy, and manage infrastructure on Google Cloud. Instead of step-by-step instructions, you'll be presented with a scenario and tasks to accomplish. Your goal is to apply the knowledge gained from the labs to figure out how to complete the tasks independently.

To score 100%, successfully complete all tasks within the allotted time. The lab is designed for students who have enrolled in the "Automating Infrastructure on Google Cloud with Terraform" quest.

## Topics Tested

1. Import existing infrastructure into your Terraform configuration.
2. Build and reference your own Terraform modules.
3. Add a remote backend to your configuration.
4. Use and implement a module from the Terraform Registry.
5. Re-provision, destroy, and update infrastructure.
6. Test connectivity between the resources you've created.

## Challenge Scenario

You are a cloud engineer intern for a new startup. Your first project involves creating infrastructure efficiently and generating a mechanism to track it for future reference and changes. Your task is to use Terraform to achieve this goal on Google Cloud. Import mismanaged instances, fix them, and create VM instances, a VPC network, subnetworks, a firewall rule, and a Cloud Storage bucket for the remote backend.

## Task 1: Create the Configuration Files

In Cloud Shell, set up your Terraform configuration files and directory structure as specified. Fill out the `variables.tf` files with default values for region, zone, and project_id. Add the Terraform block and Google Provider to `main.tf`. Verify the correctness of the arguments.
![Screenshot from 2023-12-24 03-30-15](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/6c9cf152-84b6-4c88-b2c2-c89c9045a5da)

Initialize Terraform.

## Task 2: Import Infrastructure

In the Google Cloud Console, navigate to Compute Engine > VM Instances. Import existing instances into the Terraform configuration. Write minimal configurations for instances `tf-instance-1` and `tf-instance-2` in the `instances.tf` file.
![Screenshot from 2023-12-24 03-30-32](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/45580090-42ee-4805-850b-6a1a79c3a1c6)

Apply your changes.

## Task 3: Configure a Remote Backend

Create a Cloud Storage bucket resource in the `storage` module. Reference the module in `main.tf` and configure it as the remote backend. Upon initialization, choose to copy existing state data to the new backend.
![Screenshot from 2023-12-24 03-30-41](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/945e7960-5bf8-438f-b025-361f6516e6e0)

Apply your changes.

## Task 4: Modify and Update Infrastructure

Navigate to the `instances` module and modify instance resources. Add a third instance, update configurations, and apply your changes.
![Screenshot from 2023-12-24 03-30-52](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/eaf90ab2-b2c4-4257-bcd9-d6d1a0434171)

## Task 5: Destroy Resources

Remove the third instance from the configuration, initialize Terraform, and apply the changes.
![Screenshot from 2023-12-24 03-34-19](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/2d26787b-6451-4fe6-ac0a-e7a58cb273dc)

## Task 6: Use a Module from the Registry

Browse the Terraform Registry and add the Network Module to `main.tf`. Configure VPC and subnets. Update `instances.tf` to connect instances to the appropriate subnets.
![Screenshot from 2023-12-24 03-34-47](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/fb869921-eff6-477c-ad7e-8375e65fdbcb)

## Task 7: Configure a Firewall

Create a firewall rule to permit connections on TCP port 80. Initialize Terraform and apply your changes.

![Screenshot from 2023-12-24 03-35-17](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/4ac2ac9f-5914-460e-9f80-2a270465734c)

## Solution



1. Open Cloud Shell.

2. Set the required environment variables:

    ```bash
    export ZONE=your_zone
    export BUCKET_HUSTLER=your_bucket_name
    export INSTANCE_HUSTLER=your_instance_name
    export VPC_HUSTLER=your_vpc_name
    ```

3. When prompted, type `yes` to confirm.

4. Create Terraform configuration files and initialize:

    ```bash
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
    ```

5. Set up `variables.tf`:

    ```hcl
    variable "region" {
      default = "$REGION"
    }

    variable "zone" {
      default = "$ZONE"
    }

    variable "project_id" {
      default = "$PROJECT_ID"
    }
    ```

6. Set up `main.tf`:

    ```hcl
    terraform {
      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "4.53.0"
        }
      }
    }

    provider "google" {
      project = var.project_id
      region  = var.region
      zone    = var.zone
    }

    module "instances" {
      source = "./modules/instances"
    }
    ```

7. Run Terraform initialization:

    ```bash
    terraform init
    ```

8. Set up `instances.tf` in `modules/instances`:

    ```hcl
    resource "google_compute_instance" "tf-instance-1" {
      # ... (see provided script for details)
    }

    resource "google_compute_instance" "tf-instance-2" {
      # ... (see provided script for details)
    }
    ```

9. Import existing instances and apply changes:

    ```bash
    INSTANCE_ID1=$(gcloud compute instances describe tf-instance-1 --zone=$ZONE --format="value(id)")
    INSTANCE_ID2=$(gcloud compute instances describe tf-instance-2 --zone=$ZONE --format="value(id)")
    terraform import module.instances.google_compute_instance.tf-instance-1 $INSTANCE_ID1
    terraform import module.instances.google_compute_instance.tf-instance-2 $INSTANCE_ID2
    terraform plan
    terraform apply -auto-approve
    ```

10. Set up `storage.tf` in `modules/storage`:

    ```hcl
    resource "google_storage_bucket" "storage-bucket" {
      # ... (see provided script for details)
    }
    ```

11. Set up `main.tf` for storage:

    ```hcl
    terraform {
      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "4.53.0"
        }
      }
    }

    provider "google" {
      project = var.project_id
      region  = var.region
      zone    = var.zone
    }

    module "instances" {
      source = "./modules/instances"
    }

    module "storage" {
      source = "./modules/storage"
    }
    ```

12. Run Terraform initialization and apply:

    ```bash
    terraform init
    terraform apply -auto-approve
    ```

13. Set up `main.tf` for backend configuration:

    ```hcl
    terraform {
      backend "gcs" {
        bucket  = "$BUCKET_HUSTLER"
        prefix  = "terraform/state"
      }

      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "4.53.0"
        }
      }
    }

    provider "google" {
      project = var.project_id
      region  = var.region
      zone    = var.zone
    }

    module "instances" {
      source = "./modules/instances"
    }

    module "storage" {
      source = "./modules/storage"
    }
    ```

14. Run Terraform initialization:

    ```bash
    terraform init
    ```

15. Update `instances.tf` to include your custom instance:

    ```hcl
    resource "google_compute_instance" "$INSTANCE_HUSTLER" {
      # ... (see provided script for details)
    }
    ```

16. Reapply Terraform to include the new instance:

    ```bash
    terraform apply -auto-approve
    ```

17. Taint the custom instance to force recreation:

    ```bash
    terraform taint module.instances.google_compute_instance."$INSTANCE_HUSTLER"
    terraform apply -auto-approve
    ```

18. Update `instances.tf` to use `e2-standard-2` machine type:

    ```hcl
    resource "google_compute_instance" "$INSTANCE_HUSTLER" {
      # ... (see provided script for details)
    }
    ```

19. Reapply Terraform to update the machine type:

    ```bash
    terraform apply -auto-approve
    ```

20. Set up `main.tf` for VPC module:

    ```hcl
    terraform {
      backend "gcs" {
        bucket  = "$BUCKET_HUSTLER"
        prefix  = "terraform/state"
      }

      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "4.53.0"
        }
      }
    }

    provider "google" {
      project = var.project_id
      region  = var.region
      zone    = var.zone
    }

    module "instances" {
      source = "./modules/instances"
    }

    module "storage" {
      source = "./modules/storage"
    }

    module "vpc" {
      source  = "terraform-google-modules/network/google"
      version = "~> 6.0.0"

      project_id   = "$PROJECT_ID"
      network_name = "$VPC_HUSTLER"
      routing_mode = "GLOBAL"

      subnets = [
        {
          subnet_name     = "subnet-01"
          subnet_ip       = "10.10.10.0/24"
          subnet_region   = "$REGION"
        },
        {
          subnet_name           = "subnet-02"
          subnet_ip             = "10.10.20.0/24"
          subnet_region         = "$REGION"
          subnet_private_access = "true"
          subnet_flow_logs      = "true"
          description           = "This subnet has a description"
        },
      ]
    }
    ```

21. Run Terraform initialization and apply for VPC:

    ```bash
    terraform init
    terraform apply -auto-approve
    ```

22. Update `instances.tf` to use VPC network and subnets:



    ```hcl
    resource "google_compute_instance" "$INSTANCE_HUSTLER" {
      # ... (see provided script for details)
      network_interface {
        network    = "$VPC_HUSTLER"
        subnetwork = "subnet-01"
      }
    }
    ```

23. Reapply Terraform to use the VPC network:

    ```bash
    terraform apply -auto-approve
    ```

24. Set up `main.tf` for a firewall rule:

    ```hcl
    terraform {
      backend "gcs" {
        bucket  = "$BUCKET_HUSTLER"
        prefix  = "terraform/state"
      }

      required_providers {
        google = {
          source  = "hashicorp/google"
          version = "4.53.0"
        }
      }
    }

    provider "google" {
      project = var.project_id
      region  = var.region
      zone    = var.zone
    }

    module "instances" {
      source = "./modules/instances"
    }

    module "storage" {
      source = "./modules/storage"
    }

    module "vpc" {
      source  = "terraform-google-modules/network/google"
      version = "~> 6.0.0"

      project_id   = "$PROJECT_ID"
      network_name = "$VPC_HUSTLER"
      routing_mode = "GLOBAL"

      subnets = [
        {
          subnet_name     = "subnet-01"
          subnet_ip       = "10.10.10.0/24"
          subnet_region   = "$REGION"
        },
        {
          subnet_name           = "subnet-02"
          subnet_ip             = "10.10.20.0/24"
          subnet_region         = "$REGION"
          subnet_private_access = "true"
          subnet_flow_logs      = "true"
          description           = "This subnet has a description"
        },
      ]
    }

    resource "google_compute_firewall" "tf-firewall" {
      name    = "tf-firewall"
      network = "projects/'$PROJECT_ID'/global/networks/'$VPC_HUSTLER'"

      allow {
        protocol = "tcp"
        ports    = ["80"]
      }

      source_tags    = ["web"]
      source_ranges  = ["0.0.0.0/0"]
    }
    ```

25. Run Terraform initialization and apply for the firewall rule:

    ```bash
    terraform init
    terraform apply -auto-approve
    ```
![Screenshot from 2023-12-24 03-40-41](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/415c4f49-d4d6-4f51-8b17-c54767c9ceb0)

Congratulations! You have successfully deployed and configured infrastructure components on GCP using Terraform. Be sure to review and customize the scripts according to your specific requirements before execution.
