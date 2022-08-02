# This code will produce messages and publish to the Pub/sub topic to simulate events from other systems

from google.cloud import pubsub_v1
import json
import uuid
import time
import random
from faker import Faker

topic_name = "projects/syl-data-analytics/topics/ingest-order-events"
actions = ["created", "cancelled", "updated", "delivered"]

publisher = pubsub_v1.PublisherClient()

for n in range(1, 100):
    fake = Faker()
    order = {
        "order_id": str(uuid.uuid1()),
        "customer_email": fake.free_email(),
        "phone_number": fake.phone_number(),
        "user_agent": fake.chrome(),
        "action": random.choice(actions),
        "action_time": int( time.time())
    }

    # Data must be a bytestring
    data = json.dumps(order).encode("utf-8")
    # When you publish a message, the client returns a future.
    future = publisher.publish(topic_name, data)
    print(future.result())


print(f"Published messages to {topic_name}.")
