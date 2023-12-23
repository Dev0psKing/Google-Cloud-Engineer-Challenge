# Google Kubernetes Engine (GKE) - Qwik Start

## Overview

Welcome to the Google Kubernetes Engine (GKE) Qwik Start lab. GKE provides a managed environment for deploying, managing, and scaling containerized applications using Google's infrastructure. In this lab, you'll get hands-on practice with container creation and application deployment with GKE.

## Cluster Orchestration with GKE

GKE clusters are powered by Kubernetes, an open-source cluster management system. Kubernetes enables you to deploy and manage applications, perform administrative tasks, set policies, and monitor the health of your workloads. It leverages Google's design principles and offers benefits such as automatic management, monitoring, scaling, rolling updates, and more.

### Features of GKE on Google Cloud

When you run a GKE cluster on Google Cloud, you benefit from advanced cluster management features, including:

- Load balancing for Compute Engine instances
- Node pools for flexibility in managing subsets of nodes within a cluster
- Automatic scaling of your cluster's node instance count
- Automatic upgrades for your cluster's node software
- Node auto-repair to maintain node health and availability
- Logging and Monitoring with Cloud Monitoring for visibility into your cluster

## Lab Environment Setup

Follow the steps below to set up your lab environment:

1. Open the Google Cloud Console.

2. Set the zone for your GKE cluster. Use the following command and replace `<YOUR_ZONE>` with your preferred zone:

    ```bash
    export ZONE=<YOUR_ZONE>
    ```

3. Create a GKE cluster named `lab-cluster` with the specified machine type and zone:

    ```bash
    gcloud container clusters create --machine-type=e2-medium --zone=$ZONE lab-cluster
    ```

4. Configure kubectl to use the credentials for the newly created cluster:

    ```bash
    gcloud container clusters get-credentials lab-cluster
    ```

5. Deploy a containerized application (hello-server) to the cluster:

    ```bash
    kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
    ```

6. Expose the deployment as a LoadBalancer service on port 8080:

    ```bash
    kubectl expose deployment hello-server --type=LoadBalancer --port 8080
    ```

7. Check the external IP and port assigned to the service:

    ```bash
    kubectl get service
    ```

## Cleaning Up

After completing the lab, you can delete the GKE cluster using the following command:

```bash
gcloud container clusters delete lab-cluster --zone <YOUR_ZONE>
```

## Conclusion

Congratulations on completing the GKE Qwik Start lab! You've learned how to deploy a containerized application on GKE and explored some of the advanced features it offers. Continue exploring Kubernetes and GKE to enhance your container orchestration skills.