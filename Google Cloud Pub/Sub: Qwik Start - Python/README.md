# Google Cloud Pub/Sub: Qwik Start - Python & Command Line Interface(CLI)

## Overview

Welcome to the Google Cloud Pub/Sub Qwik Start lab in Python! Google Cloud Pub/Sub facilitates reliable, quick, and asynchronous message exchange between applications. In this lab, you'll explore the basics of Pub/Sub, create and list topics and subscriptions, publish messages, and use a pull subscriber to output individual topic messages using the Python client library.

## What you'll do

1. **Learn the basics of Pub/Sub.**
2. **Create and list a Pub/Sub topic.**
3. **Create and list a Pub/Sub subscription.**
4. **Publish messages to a topic.**
5. **Use a pull subscriber to output individual topic messages.**

## Tasks

### Task 1: Create a virtual environment

```bash
sudo apt-get install -y virtualenv
python3 -m venv venv
source venv/bin/activate
```

### Task 2: Install the client library

```bash
pip install --upgrade google-cloud-pubsub
```

### Task 3: Pub/Sub - the Basics

Google Cloud Pub/Sub involves topics, publishing, and subscribing. A topic is a shared string connecting applications. Publishers push messages to a topic, and subscribers make a subscription to that thread to receive messages.

### Task 4: Create a topic

```bash
git clone https://github.com/googleapis/python-pubsub.git
cd python-pubsub/samples/snippets
python publisher.py $GOOGLE_CLOUD_PROJECT create MyTopic
```

### Task 5: Create a subscription

```bash
python subscriber.py $GOOGLE_CLOUD_PROJECT create MyTopic MySub
```

### Task 6: Publish messages

```bash
python publisher.py $GOOGLE_CLOUD_PROJECT publish MyTopic "Hello, Pub/Sub!"
```

### Task 7: View messages

Explore the output from the subscriber and view the published message.

## Solution

```bash
# Create a virtual environment
sudo apt-get install -y virtualenv
python3 -m venv venv
source venv/bin/activate

# Install the client library
pip install --upgrade google-cloud-pubsub

# Clone the Python Pub/Sub repository
git clone https://github.com/googleapis/python-pubsub.git
cd python-pubsub/samples/snippets

# Create a topic
python publisher.py $GOOGLE_CLOUD_PROJECT create MyTopic

# Create a subscription
python subscriber.py $GOOGLE_CLOUD_PROJECT create MyTopic MySub

# Publish messages
python publisher.py $GOOGLE_CLOUD_PROJECT publish MyTopic "Hello, Pub/Sub!"

# View messages (observe the subscriber output)
```
![Screenshot from 2023-12-29 13-55-37](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/a8362c45-35e2-4064-82c3-6d2121e6ba81)


### Using Cloud Shell
```bash
gcloud pubsub topics create myTopic
gcloud  pubsub subscriptions create --topic myTopic mySubscription

```
![Screenshot from 2023-12-29 14-20-16](https://github.com/Dev0psKing/Google-Cloud-Hands_On/assets/99263767/7ef827b0-2f25-4ae2-ad32-fd02e6088a6c)


Congratulations! You've completed the Google Cloud Pub/Sub Qwik Start lab in Python. Explore more and experiment with Pub/Sub for your asynchronous messaging needs.
