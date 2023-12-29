# Cloud Storage: Qwik Start - Cloud Console

## Overview

Welcome to the Cloud Storage Qwik Start lab using the Cloud Console! Cloud Storage enables you to globally store and retrieve data of any size at any time. Whether you're serving website content, archiving data for disaster recovery, or distributing large data objects for direct user downloads, Cloud Storage has you covered.

In this hands-on lab, you'll dive into the Cloud Console to perform various tasks, including creating a storage bucket, uploading objects, managing folders and subfolders, and making your stored objects publicly accessible.

## Tasks

### Task 1: Create a Bucket

Buckets serve as fundamental containers for your data in Cloud Storage. Follow the steps in the Cloud Console to create your first storage bucket.

### Task 2: Upload an Object into the Bucket

Learn how to upload objects into your newly created bucket using the Cloud Console. This fundamental task is crucial for storing and managing your data effectively.

### Task 3: Share a Bucket Publicly

Explore the process of making your bucket publicly accessible. This step is essential for scenarios where you want to share your stored content with a broader audience.

### Task 4: Create Folders

Organize your data efficiently by creating folders within your storage bucket. This helps you maintain a structured and easily navigable storage environment.

### Task 5: Delete a Folder

Discover how to delete folders in Cloud Storage when they are no longer needed. Keeping your storage organized is key to efficient data management.

## Congratulations!

You've successfully completed the Cloud Storage Qwik Start lab using the Cloud Console. By mastering these tasks, you now have a solid foundation for managing your data effectively in a cloud environment.

## Solution using Cloud Shell

```bash
# Set your preferred region
export REGION=<your-region>

# Create a storage bucket
gsutil mb -l $REGION -c Standard gs://$DEVSHELL_PROJECT_ID

# Download an image
curl -o kitten.png https://cdn.qwiklabs.com/8tnHNHkj30vDqnzokQ%2FcKrxmOLoxgfaswd9nuZkEjd8%3D

# Upload the image to your bucket
gsutil cp kitten.png gs://$DEVSHELL_PROJECT_ID/kitten.png

# Make the bucket publicly accessible
gsutil iam ch allUsers:objectViewer gs://$DEVSHELL_PROJECT_ID
```

