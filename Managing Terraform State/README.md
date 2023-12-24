# Terraform State Management

## Overview

Terraform, a powerful Infrastructure as Code (IaC) tool, relies on state to manage infrastructure and configuration. This state serves as a bridge between your defined infrastructure and the real-world resources it represents. Terraform's ability to map configurations to resources, track metadata, and optimize performance for large infrastructures hinges on effective state management.

The default storage location for Terraform state is a local file named `terraform.tfstate`. However, in collaborative team environments, remote storage proves to be more efficient.

This README provides insights into Terraform state, its significance, and guides you through various state management tasks.

## Objectives

In this lab, you will master the following tasks:

1. **Create a Local Backend**: Understand how to establish a local backend for your Terraform state.

2. **Create a Cloud Storage Backend**: Explore the benefits of storing Terraform state remotely, particularly in Cloud Storage.

3. **Refresh Your Terraform State**: Learn the importance of refreshing Terraform state before making any changes to your infrastructure.

4. **Import a Terraform Configuration**: Understand how to import existing configurations into Terraform for management.

5. **Manage the Imported Configuration**: Gain proficiency in managing and updating configurations using Terraform.

## Solution

To quickly get started, execute the following commands in your terminal:

```bash
export REGION=us-west1

curl -LO raw.githubusercontent.com/quiccklabs/Labs_solutions/master/Managing%20Terraform%20State/quicklabgsp752.sh

sudo chmod +x quicklabgsp752.sh

./quicklabgsp752.sh
```

This solution script sets up your environment efficiently for the lab, saving you time and ensuring a smooth learning experience.

### Congratulations!
In this lab, you learned how to manage backends and state with Terraform. You created local and Cloud Storage backends to manage your state file, refreshed your state, and imported configuration into Terraform. You then updated the configuration and manually edited to fully manage the Docker container with Terraform.

