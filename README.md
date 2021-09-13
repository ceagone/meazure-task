# Meazure Terraform Task

This is the terraform task is to create a cluster and deploy openfaas using Helm. 

This terraform code will create a VPC, GKE and deploy openfaas. Below are details and instructions to deploy.
## Requirements

* Gcloud CLI
* Helm CLI (Version 3)
* kubectl CLI
* Terraform minimum version = 0.12.0


## Prerequsites

* Create a GCP account to deploy the cluster if one is not available.

* Create a GCP project.

* Create a service account with necessary access (I gave it a full access to avoid some permission errors). I commented out some details about including your service account in the `gke.tf` if need be to include it.

* Generate your new ```.json``` service account key-pair and download it.

* Enable Google API on GCP to create a GKE.

## Commands to run 

* ``` gcloud auth login ``` : This is to autenticate to your GCP account from your terminnal. It automatically redirects to a browser to provide your GCP credentials.

* ``` gcloud config set project <PROVIDE-YOUR PROJECT-ID>``` : To set the project.

*  ``` gcloud projects list ``` : To verify the project you just set is available.

* ``` git clone https://github.com/aogunfowora/meazure-task.git ``` : To clone the terraform task's repo and cd into the `meazure-task` folder.

* Copy the service account's `.json` file in to the `meazure-task-1` folder. (I'd suggest you renaming it as the name will be required as part of the input variable for your tfvars).

* Create a `.tfvars`. Below is a sample with the following contents: 
```
  region = "us-central1"
  google_credentials = "PATH-to-service-acct"
  project_id = "PROJECT-ID"
  cluster_name = "NAME-OF-CLUSTER"
  cluster_image = "cos"
  cluster_machine = "e2-medium"
  min_node = 1
  max_node = 3
  node_disk_size = 20
```

* The `variables.tf` file shows more description as to each varaible set and can be changed to your preferences

* ```export CLUSTER_NAME=CLUSTER-NAME``` as provided in your `.tfvars` file to set env variable for the cluster name.

* Run ```export CLUSTER_REGION=YOUR-REGION``` as provided in your `.tfvars` file to set env variable for the region.

* Run ```export export PROJECT_ID=PROJECT-ID``` as provided in your `.tfvars` file to set env variable for the project ID.

* Run ```terraform init``` : To download the necessary Plug-ins

* Run ```terraform apply -var-file=YOUR-.tfvars-FILE```

* After resources are done creating, you should have `password.txt` file available in your `PWD`, which holds the password to accessing the deployed openfaas UI.

* Run ``` kubectl get svc -n openfaas ``` to access the LoadBalancer IP address to access openfaas. Paste `LB_IP-ADDR:8080`to access the UI. Provide `username` as `admin` and `password` as the credentials in the password.txt file you have.


## To Destroy

* Run ```terraform destroy``` to destroy everything created with Terraform

