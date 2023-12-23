# Google Cloud Platform - Compute Engine Qwik Start - Windows Lab Challenge

## Overview

Welcome to the Google Cloud Platform (GCP) Compute Engine Qwik Start - Windows lab challenge. This hands-on lab provides you with a practical experience of launching a Windows Server instance in Compute Engine and using Remote Desktop Protocol (RDP) to connect to it. Compute Engine allows you to create and run virtual machines on Google's infrastructure, offering scalability, performance, and value for running Windows applications.

## Prerequisites

Before you begin, ensure that you have the following:

- A Google Cloud Platform account.
- A project created on GCP.
- Basic knowledge of GCP Console.

## Solution


1. Open the GCP Console.

2. Set the zone for your Compute Engine instance. Use the following command to set the zone to `us-central1-c`:

    ```bash
    export ZONE=us-central1-c
    ```

3. Download the lab script using the following command:

    ```bash
    curl -LO raw.githubusercontent.com/quiccklabs/Labs_solutions/master/Compute%20Engine%20Qwik%20Start%20Windows/quicklabgsp093.sh
    ```

4. Provide execution permissions to the script:

    ```bash
    sudo chmod +x quicklabgsp093.sh
    ```

5. Execute the script to initiate the lab:

    ```bash
    ./quicklabgsp093.sh
    ```

6. Follow the on-screen instructions to complete the lab challenge.
![Screenshot from 2023-12-23 04-38-09](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/64324f55-b616-4257-b7c1-2761e68c4d37)

## Additional Information

- The lab script automates the setup process, but feel free to explore the GCP Console and understand the actions performed by the script.

- For more details on Compute Engine and Windows instances, refer to the [official documentation](https://cloud.google.com/compute/docs/instances/windows).

- If you encounter any issues during the lab, refer to the troubleshooting section in the GCP documentation or seek assistance from the Google Cloud community.

## Conclusion

Congratulations on completing the Compute Engine Qwik Start - Windows lab challenge! You've gained practical experience in launching Windows Server instances on Compute Engine and connecting to them using RDP. Feel free to explore more GCP services and continue building your cloud expertise.
