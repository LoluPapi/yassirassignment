# `Wordpress and mysql` with Terraform on Google Kubernetes Engine


This is an implementation of my [`wordpress with mysql`](https://github.com/loluPapi/yassir-wordpress-mysql) that runs on GCP through automation with Terraform. 
This Implementation uses the example K8s manifest found here [`Kubernetes Tutorial`](https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/) and skips the **need to write code, build docker, and push to registry.**
The yaml deployment for kubernetes is in the `root` folder, and Terraform files in `infra`.
A utility script to run the terraform is in the `root` folder

The setup will create:

- **1 Kubernetes Cluster**, This contains the webserver and mysql deployments
- **1 Cloud Source Repository** that will contain your code (Git repo)
- **1 Cloud Build triggers**, updates will rollout new manifest changes which will then proceed to update the cluster.
- **1 Cloud Storage bucket** 
- **1 VPC networks** with custom subnet 

Terraform configuration should mostly be driven through the `[environment].tfvars` files. This will allow the same code to have the same consistency in diffrent environment but could have different capacity, sizes , policy, retention etc.

**Warning!** 
**Here, I will list some warnings and tradeoffs**
I've not had time and possibility to polish up the manifest(Also why I didn't build docker)and automate secret creation. The mysql-secret is created manually using `kubectl create secret generic mysql-pass  --from-literal=password=<password>`. This could moved to Google Secret manager using CSI Driver.
Also I may have hard-coded may variables which shouldn't be. Some of the terraform code could fetch already created data from the state file. 
I have not used SSL or Custom domains for this project. If you have a custom domain, you can set up the DNS, SSL and Ingress.


## Prerequisites

- Terraform installed
- gcloud CLI installed
- GCP account
- Environment set up correctly

## Project structure

- `infra/modules`: These are reusabel terraform modules that can be used on multiple projects
- `infra/project-yassir`: The project that contains the IaC and Kubernetes Manifest to complete this deployment
- `/k8smanifest`: Contains 3 manifest includng the `Kustomization` yaml file that deploys the wordpress components and mysql.
- `cloudbuild.tf.yaml`: Cloud Build manifests for CI/CD to deploy the IaC (TF)
- `cloudbuild.yaml`: Cloud Build manifests for CI/CD to deploy the K8s manifest to the cluster
- `setup.sh`: Creates a GCP project for you and enables services
- `gcloud.sh`: Quick helper script to deploy the cloudbuild.tf.yaml (You can add this shell script to any CICD tool like Jenkins, Gitlab etc)

## How to deploy the stack

### 1. Google Cloud Platform

1. **Create new project**: Open `setup.sh` and modify to cover your own case, then run it (the last steps may fail if billing is not turned on)
2. Turn on billing for the project in the Billing page
3. The simplest (manual) way to create credentials, is to create a service account in the IAM page of GCP, then put the generated JSON file at the root of your drive (should be `~./.gcloud/` on Mac/Linux)

### 2. Terraform

1. Navigate to `/iac`
2. In Each folder, you will find the `Vars` folder. Input the correct variables as per the environment you will be building. e.g modify the `dev.tfvars`

### Deploy Iac 

The cloudbuild.tf.yaml consist of the steps that will execute each terraform folder in the `iac` folder.
Go to root of the repo, and run `gcloud.sh`. This will will run the the `terrafrom init`, `terraform plan` and `terraform apply`.


### 3. Deploy Application

Just commit your code to Cloud Source Repositories and it should build in Cloud Build and deploy the manifest to the cluster

### How to see the live webserver(wp)

You will see an "ephemeral IP" that will attached to the service. Go to [Kubernetes Engine](https://console.cloud.google.com/compute/instances) and find your the IP under wordpress services on the endpoint colunm. It may look like this `35.233.105.92:80`.



## Manual steps not covered by automation

- In [Cloud Build, go to settings](https://console.cloud.google.com/cloud-build/settings/) and enable `Kubernetes Engine`.
- In [Cloud Source Repositories](https://source.cloud.google.com/), you'll need to push your code from your machine to Google Git
- Create a buckset on the Cloud storage to use for your state file.
- Scan your TF code using checkov which is a static code analysis tool for scanning infrastructure as code (IaC) files for misconfigurations that may lead to security or compliance problems. 
