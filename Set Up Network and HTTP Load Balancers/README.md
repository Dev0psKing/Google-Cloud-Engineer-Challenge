# Google Cloud Platform - Set Up Network and HTTP Load Balancers

## Overview

Welcome to the Google Cloud Platform (GCP) lab on setting up Network and HTTP Load Balancers. This hands-on lab provides you with practical experience in configuring both Network Load Balancer and HTTP Load Balancer for applications running on Compute Engine virtual machines.

## Learning Objectives

In this lab, you will:

- Set up a Network Load Balancer to distribute traffic across multiple virtual machines.
- Configure an HTTP Load Balancer to balance traffic and provide high availability for your web servers.

## Lab Environment Setup

Follow the steps below to set up your lab environment:

1. Open the Google Cloud Console.

2. Set the region and zone for your lab. Use the following commands:

    ```bash
    export REGION=us-west1
    export ZONE=us-west1-c

    gcloud config set compute/region $REGION
    gcloud config set compute/zone $ZONE
    ```

3. Create three Compute Engine instances with Apache web servers:

    ```bash
    # Create VM instances with Apache web servers
    gcloud compute instances create www1 --zone=$ZONE --tags=network-lb-tag --machine-type=e2-small --image-family=debian-11 --image-project=debian-cloud --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'

    gcloud compute instances create www2 --zone=$ZONE --tags=network-lb-tag --machine-type=e2-small --image-family=debian-11 --image-project=debian-cloud --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www2</h3>" | tee /var/www/html/index.html'

    gcloud compute instances create www3 --zone=$ZONE --tags=network-lb-tag --machine-type=e2-small --image-family=debian-11 --image-project=debian-cloud --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "<h3>Web Server: www3</h3>" | tee /var/www/html/index.html'
    ```

4. Create a firewall rule to allow traffic on port 80:

    ```bash
    gcloud compute firewall-rules create www-firewall-network-lb --target-tags network-lb-tag --allow tcp:80
    ```

5. Create an external IP address for the Network Load Balancer:

    ```bash
    gcloud compute addresses create network-lb-ip-1 --region $REGION
    ```

6. Set up a basic health check for HTTP Load Balancer:

    ```bash
    gcloud compute http-health-checks create basic-check
    ```

7. Create a target pool and add instances to it:

    ```bash
    gcloud compute target-pools create www-pool --region $REGION --http-health-check basic-check
    gcloud compute target-pools add-instances www-pool --instances www1,www2,www3
    ```

8. Create a forwarding rule for the Network Load Balancer:

    ```bash
    gcloud compute forwarding-rules create www-rule --region $REGION --ports 80 --address network-lb-ip-1 --target-pool www-pool
    ```

9. Display the external IP assigned to the Network Load Balancer:

    ```bash
    gcloud compute forwarding-rules describe www-rule --region $REGION --format="json" | jq -r .IPAddress
    ```

10. Test the Network Load Balancer:

    ```bash
    while true; do curl -m1 <EXTERNAL_IP>; done
    ```

## HTTP Load Balancer Setup

11. Create an instance template for HTTP Load Balancer:

    ```bash
    gcloud compute instance-templates create lb-backend-template --region=$REGION --network=default --subnet=default --tags=allow-health-check --machine-type=e2-medium --image-family=debian-11 --image-project=debian-cloud --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      a2ensite default-ssl
      a2enmod ssl
      vm_hostname="$(curl -H "Metadata-Flavor:Google" http://169.254.169.254/computeMetadata/v1/instance/name)"
      echo "Page served from: $vm_hostname" | tee /var/www/html/index.html
      systemctl restart apache2'
    ```

12. Create a managed instance group:

    ```bash
    gcloud compute instance-groups managed create lb-backend-group --template=lb-backend-template --size=2 --zone=$ZONE
    ```

13. Create a firewall rule to allow health check:

    ```bash
    gcloud compute firewall-rules create fw-allow-health-check --network=default --action=allow --direction=ingress --source-ranges=130.211.0.0/22,35.191.0.0/16 --target-tags=allow-health-check --rules=tcp:80
    ```

14. Create a global IP address for HTTP Load Balancer:

    ```bash
    gcloud compute addresses create lb-ipv4-1 --ip-version=IPV4 --global
    ```

15. Display the global IP address assigned to HTTP Load Balancer:

    ```bash
    gcloud compute addresses describe lb-ipv4-1 --format="get(address)" --global
    ```

16. Create a health check for HTTP Load Balancer:

    ```bash
    gcloud compute health-checks create http http-basic-check --port 80
    ```

17. Create a backend service and add instances to it:

    ```bash
    gcloud compute backend-services create web-backend-service --protocol=HTTP --port-name=http --health-checks=http-basic-check --global
    gcloud compute backend-services add-backend web-backend-service --instance-group=lb-backend-group --instance-group-zone=$ZONE --global
    ```

18. Create a URL map for HTTP Load Balancer:

    ```bash
    gcloud compute url-maps create web-map-http --default-service web-backend-service
    ```

19. Create a target HTTP proxy:

    ```bash
    gcloud compute target-http-proxies create http-lb-proxy --url-map web-map-http
    ```

20. Create a forwarding rule for HTTP Load Balancer:

    ```bash
    gcloud compute forwarding-rules create http-content-rule --address=lb-ipv4-1 --global --target-http-proxy=http-lb-proxy --ports=80
    ```

## Conclusion

Congratulations! You have successfully set up both Network and HTTP Load Balancers on Google Cloud Platform. You now have hands-on experience with configuring load balancers to distribute traffic and provide high availability for your applications running on Compute Engine virtual machines. Feel free to explore more advanced load balancing configurations and continue building your skills on Google Cloud.