# Pub/sub to BigGuery streaming

## Description

This example demonstrates how to configure a Serverless data streaming solution using Pub/sub to BigQuery.

Resources created:
- BigQuery data sets and tables
- Pub/sub topic and BQ subscription

## Deploy

1. Create a new project and select it
2. Open Cloud Shell and ensure the env var below is set, otherwise set it with `gcloud config set project` command
```
echo $GOOGLE_CLOUD_PROJECT
```

3. Create a bucket to store your project's Terraform state
```
gsutil mb gs://$GOOGLE_CLOUD_PROJECT-tf-state
```

4. Enable the necessary APIs
```
gcloud services enable bigquery.googleapis.com \
    bigquerydatatransfer.googleapis.com \
    cloudfunctions.googleapis.com \
    pubsub.googleapis.com \
    run.googleapis.com \
    storage.googleapis.com
```

5. Go to [IAM](https://console.cloud.google.com/iam-admin/iam) and add `Editor`, `Network Admin` and `Security Admin` role to the Cloud Build's service account `<PROJECT_NUMBER>@cloudbuild.gserviceaccount.com`.

6. Clone this repo
```
git clone https://github.com/sylvioneto/gcp-data-analytics.git
cd ./gcp-data-analytics/pubsub-to-bigquery
```

7. Execute Terraform using Cloud Build
```
gcloud builds submit . --config cloudbuild.yaml
```

## Destroy
1. Execute Terraform using Cloud Build
```
cd ./gcp-data-analytics/pubsub-to-bigquery
gcloud builds submit . --config cloudbuild_destroy.yaml
```


## Load Test
If you want to run a load test, please follow the instructions below.

1. Set GCP_TOKEN env var
```
export GCP_TOKEN=$(gcloud auth print-identity-token)
```

2. Run locust with your Cloud Run Service URL as target, for example:
```
locust -f locustfile.py --headless -u 100 -r 10 \
    --run-time 30m \
    -H https://order-event-ingest-api-myuqqqnhdq-ue.a.run.app 
```
