#!/bin/bash

# Google Kubernetes Engine (GKE)/setup.sh
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



export ZONE=us-central1-a

gcloud container clusters create --machine-type=e2-medium --zone=$ZONE lab-cluster
gcloud container clusters get-credentials lab-cluster
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment hello-server --type=LoadBalancer --port 8080
kubectl get service


#kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
#kubectl expose deployment hello-server --type=LoadBalancer --port 8080
#kubectl get service

gcloud container clusters delete lab-cluster --zone us-central1-a