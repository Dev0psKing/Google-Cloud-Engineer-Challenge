#!/bin/bash

export ZONE=europe-west1-c


echo -e "ZONE: $ZONE"


gcloud compute instances create gcelab2 --machine-type e2-medium --zone $ZONE