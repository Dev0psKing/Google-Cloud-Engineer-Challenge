# Terraform Modules Deep Dive

## Overview

As you dive deeper into managing your infrastructure with Terraform, the complexity of your configurations is likely to increase. However, a single Terraform configuration file or directory can become unwieldy as complexity grows. This README explores the challenges that may arise and introduces Terraform modules as a powerful solution to enhance organization, encapsulation, reusability, and consistency in your configurations.

## Challenges

As configurations evolve, you might encounter the following challenges:

- **Difficulty in Navigation**: Complex configurations make it challenging to understand and navigate.

- **Risky Updates**: Updates become riskier, as modifications to one block may have unintended consequences on other blocks.

- **Increased Duplication**: Duplication of similar configuration blocks may surge, especially in multiple environments, leading to maintenance challenges.

- **Sharing Configurations**: Sharing configurations between projects and teams can be error-prone and challenging to maintain.

## What Are Modules For?

Terraform modules serve as a remedy to the challenges mentioned above. Here's how modules address these issues:

- **Organize Configuration**: Modules make it easier to organize related configuration components logically, enhancing navigation and understanding.

- **Encapsulate Configuration**: Modules encapsulate configurations into distinct logical components, reducing unintended consequences and minimizing errors.

- **Re-use Configuration**: Save time and reduce errors by reusing configurations written by yourself, your team, or the broader Terraform community.

- **Consistency and Best Practices**: Modules ensure consistency across configurations, applying best practices uniformly, especially crucial when dealing with complex services like cloud object storage.

## Objectives

In this lab, you will learn:

1. **Use a Module from the Registry**: Explore utilizing pre-built modules from the Terraform Registry.

2. **Build a Module**: Gain hands-on experience creating your own Terraform module for managing infrastructure.

## My Solutions

To quickly get started, execute the following commands in your terminal:

```bash
export PROJECT_ID=$(gcloud config get-value project)

git clone https://github.com/terraform-google-modules/terraform-google-network
cd terraform-google-network
git checkout tags/v6.0.1 -b v6.0.1

# Creating a sample module
echo 'module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 6.0"
  project_id   = var.project_id
  network_name = var.network_name
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name               = "subnet-03"
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = "us-west1"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter   = "false"
    }
  ]
}' > examples/simple_project/main.tf

echo 'variable "project_id" {
  description = "The project ID to host the network in Cloudhustler"
  default     = "'"$PROJECT_ID"'"
}
variable "network_name" {
  description = "The name of the VPC network being created Hustler"
  default     = "cloudhustlers"
}' > examples/simple_project/variables.tf

# Initializing and applying the module
cd examples/simple_project
terraform init
terraform apply -auto-approve

# Destroying the created resources
terraform destroy -auto-approve

# Cleaning up
rm -rd terraform-google-network -f
cd ~

# Creating a Google Cloud Storage bucket
gsutil mb gs://$PROJECT_ID

# Uploading sample HTML files to the bucket
curl https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/master/modules/aws-s3-static-website-bucket/www/index.html > index.html
curl https://raw.githubusercontent.com/hashicorp/learn-terraform-modules/blob/master/modules/aws-s3-static-website-bucket/www/error.html > error.html
gsutil cp *.html gs://$PROJECT_ID
```
![Screenshot from 2023-12-24 13-22-28](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/14d0346f-d613-4711-8630-a58c39566448)
![Screenshot from 2023-12-24 13-26-56](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/f778ca10-0ecb-4766-8e9e-355ddee0bd7d)

This script streamlines the process of setting up your environment, utilizing modules, and interacting with cloud storage. Feel free to reach out if you encounter any issues or have questions. Happy Terraforming!
