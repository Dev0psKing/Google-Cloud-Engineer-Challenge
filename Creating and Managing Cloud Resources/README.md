# Create and Manage Cloud Resources: Challenge Lab || [GSP313](https://www.cloudskillsboost.google/focuses/10258?parent=catalog) 

### Challenge scenario
You have started a new role as a Junior Cloud Engineer for Jooli, Inc. You are expected to help manage the infrastructure at Jooli. Common tasks include provisioning resources for projects.

You are expected to have the skills and knowledge for these tasks, so step-by-step guides are not provided.

Some Jooli, Inc. standards you should follow:

Create all resources in the default region or zone, unless otherwise directed. The default region is REGION, and the default zone is ZONE.
Naming normally uses the format team-resource; for example, an instance could be named nucleus-webserver1.
Allocate cost-effective resource sizes. Projects are monitored, and excessive resource use will result in the containing project's termination (and possibly yours), so plan carefully. This is the guidance the monitoring team is willing to share: unless directed, use e2-micro for small Linux VMs, and use e2-medium for Windows or other applications, such as Kubernetes nodes.

#### Your challenge
As soon as you sit down at your desk and open your new laptop, you receive several requests from the Nucleus team. Read through each description, and then create the resources.

## Solution 
### Assign Veriables

```
export INSTANCE=
export PORT_NO=
export FIREWALL=
export REGION=
export ZONE=
```
![Screenshot from 2023-12-22 05-32-50](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/010dca7e-0f2a-4106-a18d-e090965c8adb)

### Task 1. Create a project jumphost instance

```
gcloud compute instances create $INSTANCE \
    --zone=$ZONE \
    --machine-type=e2-micro
```
![Screenshot from 2023-12-22 05-33-24](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/64546dee-bd97-4684-bddf-ef26edac96f3)

### Task 2. Create a Kubernetes service cluster

```
gcloud container clusters create nucleus-backend \
    --num-nodes=1 \
    --zone=$ZONE
```
![Screenshot from 2023-12-22 05-40-40](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/bc6798a0-ace2-4d99-9b88-cecf08fe95a7)

```
gcloud container clusters get-credentials nucleus-backend \
          --zone $ZONE
```
![Screenshot from 2023-12-22 05-41-43](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/f19cd04e-c7c5-46d7-bc70-99b46d4c7eb2)

```
kubectl create deployment hello-server \
          --image=gcr.io/google-samples/hello-app:2.0
```
![Screenshot from 2023-12-22 05-43-09 (copy)](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/98949aaa-beeb-4e24-ba99-185f826340e5)

```
kubectl expose deployment hello-server \
          --type=LoadBalancer \
          --port $PORT_NO
```
![Screenshot from 2023-12-22 05-43-09 (copy)](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/78e95603-6fc2-4a02-bc7b-f0fbf0cf9a62)

### Task 3. Set up an HTTP load balancer

```
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF
```
```
gcloud compute instance-templates create web-server-template \
       --metadata-from-file startup-script=startup.sh \
       --machine-type g1-small \
       --region $REGION
```
![Screenshot from 2023-12-22 05-44-05](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/f35af74d-8575-4ed4-9aa0-a1485f983a40)

```
gcloud compute target-pools create nginx-pool --region $REGION
```
![Screenshot from 2023-12-22 05-44-29](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/0c4544ed-76c8-4732-b31f-c7326b8117ec)

```
gcloud compute instance-groups managed create web-server-group \
--base-instance-name web-server \
--size 2 \
--template web-server-template \
--region $REGION
```
![Screenshot from 2023-12-22 05-44-55](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/53f20c8a-8263-4cf2-9a15-437d1cb76da8)

```
gcloud compute firewall-rules create $FIREWALL \
       --allow tcp:80
```
![Screenshot from 2023-12-22 05-45-20](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/7238209c-e572-481c-853f-835d9dd38789)

```
gcloud compute http-health-checks create http-basic-check
```
![Screenshot from 2023-12-22 05-47-49](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/bc73d594-3dc9-4ff5-b016-1e01189b5159)

```
gcloud compute instance-groups managed \
       set-named-ports web-server-group \
       --named-ports http:80 \
       --region $REGION
```
![Screenshot from 2023-12-22 05-49-09](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/907c9bd0-35ec-45d2-a11f-56a446729cc3)

```
gcloud compute backend-services create web-server-backend \
       --protocol HTTP \
       --http-health-checks http-basic-check \
       --global
```
```
gcloud compute backend-services add-backend web-server-backend \
       --instance-group web-server-group \
       --instance-group-region $REGION \
       --global
```
```
gcloud compute url-maps create web-server-map \
       --default-service web-server-backend
```
```
gcloud compute target-http-proxies create http-lb-proxy \
       --url-map web-server-map
```
![Screenshot from 2023-12-22 05-49-31](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/5802c35c-6183-433c-8a13-b328539bc6c2)

```
gcloud compute forwarding-rules create $FIREWALL \
     --global \
     --target-http-proxy http-lb-proxy \
     --ports 80
```
![Screenshot from 2023-12-22 05-50-19](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/f375e2bb-eeac-403c-b915-7f141d616b75)

```
gcloud compute forwarding-rules list
```
![Screenshot from 2023-12-22 05-50-33](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/a0dd104b-4ff6-4100-8e51-e2eb0d8ee0d6)


* *Note: You may need to wait for `5 to 7` `minutes` to get the score for this task.*

### Congratulations 🎉 for completing the Challenge Lab !

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*
