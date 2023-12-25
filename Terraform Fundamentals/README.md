# Terraform Fundamentals

## Overview

Terraform, an open-source infrastructure as code (IaC) tool, empowers users to create, modify, and enhance infrastructure in a safe and predictable manner. Through declarative configuration files, Terraform codifies APIs, making infrastructure management efficient and scalable. These configuration files, treated as code, can be shared, edited, reviewed, and versioned, enabling collaborative and streamlined development.

## What You'll Learn

In this lab, you will gain hands-on experience with Terraform by accomplishing the following tasks:

1. **Get Started with Terraform in Google Cloud**: Begin your Terraform journey in the Google Cloud environment.

2. **Install Terraform from Installation Binaries**: Learn the process of installing Terraform using installation binaries.

3. **Create a VM Instance Infrastructure using Terraform**: Dive into creating a virtual machine (VM) instance infrastructure through Terraform.

## My Solution

### Initialization

Initialize your Terraform configuration by running the following command. This step downloads and installs the necessary provider binary for Google Cloud.

```bash
terraform init
```

### Create an Execution Plan

Generate an execution plan to preview the changes that Terraform will apply to your infrastructure. This step ensures that the planned actions align with your expectations before making any actual changes.

```bash
terraform plan
```

This command performs a refresh, assesses the necessary actions to achieve the desired state specified in the configuration files, and provides you with insights into the upcoming changes.

### Apply Changes

To apply the changes and create the specified resources, run the following command:

```bash
terraform apply
```

The execution plan will be executed, and Terraform will create the infrastructure as defined in your configuration files. Review the output to confirm the changes and ensure they align with your expectations.

Feel free to reach out if you have any questions or encounter issues during the process. Happy Terraforming!