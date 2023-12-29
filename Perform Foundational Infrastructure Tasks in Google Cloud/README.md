# Perform Foundational Infrastructure Tasks in Google Cloud: Challenge Lab

## Introduction

Welcome to the Challenge Lab on Foundational Infrastructure Tasks in Google Cloud! In this challenge, you'll apply your skills as a junior cloud engineer at Jooli Inc. to assist a newly formed development team with configuring their application development environment for a project called "memories." Unlike traditional labs, you won't receive step-by-step instructions; instead, use your knowledge to figure out how to complete the tasks independently.

**Challenge Scenario:**
You're tasked with setting up initial configurations for the "memories" project. This involves creating a bucket for storing photographs, setting up a Pub/Sub topic for a Cloud Function, creating the Cloud Function itself, and removing access for the previous cloud engineer.

**Jooli Inc. Standards:**
- Create resources in the specified region and zone.
- Use project VPCs.
- Follow the team-resource naming convention.
- Use cost-effective resource sizes (e.g., e2-micro for small Linux VMs).
- Complete all tasks within the allocated time to score 100%.

## Your Challenge

### Task 1: Create a Bucket

```bash
export REGION=<your-region>
export ZONE=<your-zone>
gsutil mb -l $REGION -c Standard gs://$DEVSHELL_PROJECT_ID-bucket
```

### Task 2: Create a Pub/Sub Topic

```bash
export TOPIC_NAME=<your-topic-name>
gcloud pubsub topics create $TOPIC_NAME
```

### Task 3: Create the Thumbnail Cloud Function

```bash
export FUNCTION_NAME=<your-function-name>
export REGION=${ZONE::-2}
gcloud functions deploy $FUNCTION_NAME \
--runtime nodejs14 \
--trigger-resource $DEVSHELL_PROJECT_ID-bucket \
--trigger-event google.storage.object.finalize \
--entry-point thumbnail \
--region=$REGION
```

### Task 4: Test the Infrastructure

```bash
curl -o map.jpg https://storage.googleapis.com/cloud-training/gsp315/map.jpg
gsutil cp map.jpg gs://$DEVSHELL_PROJECT_ID-bucket/map.jpg
```

### Task 5: Remove the Previous Cloud Engineer

```bash
export USERNAME2=<previous-cloud-engineer-username>
gcloud projects remove-iam-policy-binding $DEVSHELL_PROJECT_ID \
--member=user:$USERNAME2 \
--role=roles/viewer
```
![Screenshot from 2023-12-29 08-26-29](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/005fef52-a223-475f-af22-5c56a5b121c8)

**Note:** Replace placeholders such as `<your-region>`, `<your-zone>`, `<your-topic-name>`, `<your-function-name>`, and `<previous-cloud-engineer-username>` with the appropriate values.

Congratulations!


![image](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/970981d6-0d03-4f02-8050-786c55690d65)
