sudo apt-get install -y virtualenv
python3 -m venv venv
source venv/bin/activate
pip install --upgrade google-cloud-pubsub
git clone https://github.com/googleapis/python-pubsub.git
cd python-pubsub/samples/snippets
python publisher.py $GOOGLE_CLOUD_PROJECT create MyTopic
python subscriber.py $GOOGLE_CLOUD_PROJECT create MyTopic MySub

# using the Cloud Shell, you can also run these commands in the Cloud Shell.
gcloud pubsub topics create myTopic
gcloud  pubsub subscriptions create --topic myTopic mySubscription