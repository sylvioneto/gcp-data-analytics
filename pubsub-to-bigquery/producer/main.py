# This code will publish messages to the Pub/sub topic to simulate events from other systems

from google.cloud import pubsub_v1
import json
import uuid
import time
import random
import os
from faker import Faker
import functions_framework


topic_name = "projects/{}/topics/ingest-order-events".format(os.getenv("PROJECT_ID"))
actions = ["created", "cancelled", "updated", "delivered"]


@functions_framework.http
def pubsub_producer(request):
    publisher = pubsub_v1.PublisherClient()

    for i in range(1, 50):
        fake = Faker()
        order = {
            "order_id": str(uuid.uuid1()),
            "customer_email": fake.free_email(),
            "phone_number": fake.phone_number(),
            "user_agent": fake.chrome(),
            "action": random.choice(actions),
            "action_time": int(time.time())
        }

        # Data must be a bytestring
        data = json.dumps(order).encode("utf-8")
        # When you publish a message, the client returns a future.
        future = publisher.publish(topic_name, data)
        print(future.result())

    return f"Published messages to {topic_name}."
