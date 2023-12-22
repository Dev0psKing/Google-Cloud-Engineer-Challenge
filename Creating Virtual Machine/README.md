# TechVine Solution

Welcome to the TechVine Solution repository! This README provides a comprehensive guide on setting up and managing instances using Google Cloud Platform.


### Scenario:

Imagine you are a DevOps engineer at TechVine Solutions, and your team is responsible for managing and configuring instances on Google Cloud Platform (GCP). The team is currently working on a project that involves deploying web servers and configuring firewall rules. The project requirements include creating instances named "gcelab" and "gcelab2" with specific configurations and ensuring that HTTP traffic is allowed to instances tagged with "http-server."

Your team has already prepared a detailed README with instructions on setting up the environment, creating instances, configuring firewall rules, and installing Nginx on the instances. As a DevOps engineer, you are tasked with executing these instructions to set up the project environment.

**Question:**

1. **Environment Setup:**
   - Explain the significance of setting the `TECHVINE_SOLUTION_ZONE` variable before proceeding with any GCP commands.
   - What could be the potential impact of not specifying the zone in the variable when creating instances?

2. **Instance Creation and Configuration:**
   - Walk through the steps involved in creating an instance named "gcelab" using the provided commands. Include any specific parameters and their importance.
   - Describe the purpose of the firewall rule created using the command for allowing HTTP traffic.

3. **SSH Access and Nginx Installation:**
   - How would you SSH into the "gcelab" instance, and why is this step necessary?
   - What are the commands for updating packages, installing Nginx, and checking its status on the "gcelab" instance?

4. **Second Instance Deployment:**
   - Briefly outline the process of creating a second instance named "gcelab2" with the specified machine type and zone.
   - Why might a team choose to deploy multiple instances for a project, and what benefits could this bring to the application architecture?

    
## Setting Up the Environment

### Zone Configuration

Before you begin, make sure to set up a variable for your preferred zone.

```bash
export TECHVINE_SOLUTION_ZONE=<your_zone>
```

## Task 1: Creating and Configuring an Instance

### Create a New Instance

To create a new instance named "gcelab" with specific configurations, execute the following command:

```bash
gcloud compute instances create gcelab \
  --zone=$TECHVINE_SOLUTION_ZONE \
  --machine-type=e2-medium \
  --image-project=debian-cloud \
  --image-family=debian-11 \
  --tags=http-server
```

### Configure Firewall Rules

Create a firewall rule to allow HTTP traffic to instances with the "http-server" tag:

```bash
gcloud compute firewall-rules create allow-http \
  --action=ALLOW \
  --direction=INGRESS \
  --rules=tcp:80 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=http-server
```

### SSH into the Instance

To SSH into the "gcelab" instance, use the following command:

```bash
gcloud compute ssh gcelab --zone=$TECHVINE_SOLUTION_ZONE --quiet
```

## Task 2: Installing Nginx on the Instance

Execute the following commands to update packages, install Nginx, and check its status:

```bash
sudo apt-get update
sudo apt-get install -y nginx
ps aux | grep nginx
exit
```

## Task 3: Creating a Second Instance

To create a second instance named "gcelab2" with specified configurations, run the following command:

```bash
gcloud compute instances create gcelab2 --machine-type e2-medium --zone=$TECHVINE_SOLUTION_ZONE
```

Congratulations! You have successfully completed the TechVine Solution.