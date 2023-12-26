# Kubernetes Engine Deployment Management

## Overview
DevOps practices often involve managing deployments for various application deployment scenarios, such as continuous deployment, blue-green deployments, and canary deployments. This lab provides hands-on experience with Kubernetes Engine, allowing you to scale and manage containers to achieve these common deployment scenarios.

## Objectives
- Practice using the `kubectl` tool
- Create deployment YAML files
- Launch, update, and scale deployments
- Explore different deployment styles

## Prerequisites
To maximize your learning experience, it is recommended that you:
- Completed the following Google Cloud Skills Boost labs:
  - Introduction to Docker
  - Hello Node Kubernetes
- Possess Linux System Administration skills
- Have a solid understanding of DevOps theory, including concepts of continuous deployment.

## Introduction to Deployments
Heterogeneous deployments involve connecting distinct infrastructure environments to address specific technical or operational needs. These deployments can be hybrid, multi-cloud, or public-private. This lab focuses on scenarios spanning regions within a single cloud environment, multiple public cloud environments, or a combination of on-premises and public cloud environments.

Challenges in single-environment deployments:
- Maxed-out resources
- Limited geographic reach
- Limited availability
- Vendor lock-in
- Inflexible resources

Heterogeneous deployments help address these challenges but require careful architecture and programmatic processes for provisioning, configuration, and maintenance.

## Solution
Follow the steps below to set up and manage Kubernetes deployments:

```bash
# Set your preferred zone
export ZONE=

# Configure Google Cloud zone
gcloud config set compute/zone $ZONE

# Copy necessary files
gsutil -m cp -r gs://spls/gsp053/orchestrate-with-kubernetes .
cd orchestrate-with-kubernetes/kubernetes

# Create Kubernetes cluster
gcloud container clusters create bootcamp \
  --machine-type e2-small \
  --num-nodes 3 \
  --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"

# Update deployment image
sed -i 's/image: "kelseyhightower\/auth:2.0.0"/image: "kelseyhightower\/auth:1.0.0"/' deployments/auth.yaml
kubectl create -f deployments/auth.yaml

# Check deployments and pods
kubectl get deployments
kubectl get pods

# Create services
kubectl create -f services/auth.yaml
kubectl create -f deployments/hello.yaml
kubectl create -f services/hello.yaml

# Create secrets and configmaps
kubectl create secret generic tls-certs --from-file tls/
kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf

# Deploy frontend
kubectl create -f deployments/frontend.yaml
kubectl create -f services/frontend.yaml

# Check frontend service
kubectl get services frontend
sleep 10

# Scale deployments
kubectl scale deployment hello --replicas=5
kubectl get pods | grep hello- | wc -l
kubectl scale deployment hello --replicas=3
kubectl get pods | grep hello- | wc -l

# Update deployment image again
sed -i 's/image: "kelseyhightower\/auth:1.0.0"/image: "kelseyhightower\/auth:2.0.0"/' deployments/hello.yaml
kubectl get replicaset

# Rollout history and management
kubectl rollout history deployment/hello
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'
kubectl rollout resume deployment/hello
kubectl rollout status deployment/hello
kubectl rollout undo deployment/hello
kubectl rollout history deployment/hello
kubectl get pods -o jsonpath --template='{range .items[*]}{.metadata.name}{"\t"}{"\t"}{.spec.containers[0].image}{"\n"}{end}'

# Create canary deployment
kubectl create -f deployments/hello-canary.yaml
kubectl get deployments
```
![Screenshot from 2023-12-26 15-17-37](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/a458d01e-8fd8-4aca-b082-3f770f3a25e9)

These commands guide you through setting up a Kubernetes cluster, managing deployments, scaling, updating images, and exploring deployment history.

## Conclusion
By completing this lab, you gain valuable experience in managing Kubernetes deployments for various scenarios, enhancing your skills in DevOps practices.
