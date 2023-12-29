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
