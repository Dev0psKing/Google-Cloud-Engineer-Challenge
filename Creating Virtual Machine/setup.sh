#!/bin/bash

# Create a variable for zone

export TECHVINE_SOLUTION_ZONE=

# shellcheck disable=SC2215
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Task1:

#Create a new instance named "gcelab"
gcloud compute instances create gcelab \
  --zone=$TECHVINE_SOLUTION_ZONE \
  --machine-type=e2-medium \
  --image-project=debian-cloud \
  --image-family=debian-11 \
  --tags=http-server

#Create a firewall rule to allow HTTP traffic to instances with the "http-server" tag
gcloud compute firewall-rules create allow-http \
  --action=ALLOW \
  --direction=INGRESS \
  --rules=tcp:80 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=http-server


#SSH into the "gcelab" instance
gcloud compute ssh gcelab --zone=$TECHVINE_SOLUTION_ZONE --quiet

# shellcheck disable=SC2215
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------


## Task2:
sudo apt-get update
sudo apt-get install -y nginx
ps auwx | grep nginx
exit

# shellcheck disable=SC2215
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## Task3:
gcloud compute instances create gcelab2 --machine-type e2-medium --zone=$TECHVINE_SOLUTION_ZONE