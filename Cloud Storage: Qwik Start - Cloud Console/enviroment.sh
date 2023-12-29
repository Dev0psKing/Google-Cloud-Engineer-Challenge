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

# Share Bucket Publicly
gsutil mb gs://$DEVSHELL_PROJECT_ID
curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output ada.jpg
gsutil cp ada.jpg gs://$DEVSHELL_PROJECT_ID
rm ada.jpg
gsutil cp -r gs://$DEVSHELL_PROJECT_ID/ada.jpg .
gsutil cp gs://$DEVSHELL_PROJECT_ID/ada.jpg gs://$DEVSHELL_PROJECT_ID/image-folder/
gsutil acl ch -u AllUsers:R gs://$DEVSHELL_PROJECT_ID/ada.jpg