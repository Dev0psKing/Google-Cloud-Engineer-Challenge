# Google Cloud Platform - Getting Started with Cloud Shell and gcloud

## Overview

Welcome to the Google Cloud Platform (GCP) lab on Getting Started with Cloud Shell and gcloud. Cloud Shell provides you with command-line access to computing resources hosted on Google Cloud, allowing you to manage your projects and resources efficiently. This lab focuses on connecting to computing services on Google Cloud via Cloud Shell using the gcloud command-line tool.

## Prerequisites

Before you begin, ensure that you have the following:

- A Google Cloud Platform account.
- Familiarity with standard Linux text editors such as vim, emacs, or nano.

## Solution

Follow the steps below to complete the lab:

1. Open the Google Cloud Console.

2. Set the zone for your Compute Engine instance. Use the following command to set the zone to `europe-west1-c`:

    ```bash
    export ZONE=europe-west1-c
    ```

3. Display the selected zone:

    ```bash
    echo -e "ZONE: $ZONE"
    ```

4. Use the gcloud command to create a Compute Engine instance named `gcelab2`. Choose the machine type as `e2-medium` and specify the zone:

    ```bash
    gcloud compute instances create gcelab2 --machine-type e2-medium --zone $ZONE
    ```

5. Follow any on-screen prompts to confirm and complete the instance creation.

## Additional Information

- Cloud Shell is a Debian-based virtual machine with a persistent 5-GB home directory, providing you with a consistent environment for managing your Google Cloud projects.

- Explore additional gcloud commands to interact with various Google Cloud services. The [official documentation](https://cloud.google.com/sdk/gcloud) is a valuable resource for learning more about gcloud commands.

- Feel free to use Cloud Shell to experiment with other GCP services and resources.

## Conclusion

Congratulations on completing the Getting Started with Cloud Shell and gcloud lab! You've gained hands-on experience in using Cloud Shell and the gcloud command-line tool to connect to computing services on Google Cloud. Continue exploring GCP features and enhancing your cloud management skills.