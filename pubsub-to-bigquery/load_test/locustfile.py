# This code will publish messages to the Pub/sub topic to simulate events from other systems

from locust import HttpUser, task
import uuid
import time
import random
from faker import Faker
import os
import json


actions = ["created", "cancelled", "updated", "delivered"]


class IngestAPIUser(HttpUser):

    @task()
    def call_ingest_api(self):
        fake = Faker()
        order = {
                "order_id": str(uuid.uuid1()),
                "customer_email": fake.free_email(),
                "phone_number": fake.phone_number(),
                "user_agent": fake.chrome(),
                "action": random.choice(actions),
                "action_time": int(time.time())
            }
        data = json.dumps(order).encode("utf-8")
        token_string = os.getenv("GCP_TOKEN")
        self.client.headers = {'Authorization': "Bearer "+token_string}
        self.client.post(f"/", data=data)
        
