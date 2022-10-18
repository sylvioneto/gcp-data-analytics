# GCP Streaming data

## Description

This example demonstrates how to stream data from your application to BigQuery using Pub/sub.

Resources created:
- BigQuery data sets and tables
- Pub/sub topic and BQ subscription

## Pre-req
The ingest API uses private docker image, so before running the terraform, make sure you:
1. Build [this docker image](https://github.com/sylvioneto/gcp-ingest-api) and store it into your project
2. Replace the image URL in [cloud_run.tf](./terraform/variables.tf#L24)


## Deploy


<a href="https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fsylvioneto%2Fgcp-streaming-data%2Ftree%2Fdeploystack&shellonly=true&cloudshell_image=gcr.io/ds-artifacts-cloudshell/deploystack_custom_image" target="_new">
    <img alt="Open in Cloud Shell" src="https://gstatic.com/cloudssh/images/open-btn.svg">
</a>

Clicking this link will take you right to the DeployStack app, running in your 
Cloud Shell environment. It will walk you through setting up your architecture.  


## Destroy
1. Execute Terraform using Cloud Build
```
gcloud builds submit . --config cloudbuild_destroy.yaml
```
