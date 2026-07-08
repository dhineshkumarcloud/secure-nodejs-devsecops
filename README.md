# Secure Deployment of Containerized Node.js Application on Google Cloud using DevSecOps Principles

## Assignment Overview

This project demonstrates the end-to-end implementation of a secure DevSecOps pipeline for deploying a containerized Node.js REST API on Google Cloud Platform (GCP).

The solution provisions all cloud infrastructure using Terraform, implements secure CI/CD using GitHub Actions with Workload Identity Federation (OIDC), deploys the application to Cloud Run, securely connects to Cloud SQL over a private network, stores secrets in Google Secret Manager, and implements monitoring with Cloud Monitoring.

This project follows DevSecOps best practices, including:

- Infrastructure as Code (Terraform)
- Least Privilege IAM
- Secret Management
- Secure Authentication using OIDC
- Automated CI/CD
- Container Security
- Centralized Logging
- Monitoring and Alerting

---

## Assignment Objectives

- Develop a containerized Node.js REST API.
- Provision infrastructure using Terraform.
- Deploy the application to Cloud Run.
- Securely connect Cloud Run to Cloud SQL over Private IP.
- Store sensitive information in Secret Manager.
- Build secure CI/CD pipelines using GitHub Actions.
- Implement monitoring, logging, and alerting.
- Follow DevSecOps security best practices throughout the project.

---

## Project Outcome

The project successfully delivers:

- Automated infrastructure provisioning using Terraform.
- Secure application deployment using Cloud Run.
- Cloud SQL integration over Private IP.
- Secure secret management.
- GitHub Actions CI pipeline.
- GitHub Actions CD pipeline using OIDC authentication.
- Logs-based monitoring and alerting.
- End-to-end automated deployment with minimal manual intervention.

---

## Solution Architecture

The application is designed using a secure and scalable serverless architecture on Google Cloud Platform. All infrastructure components are provisioned using Terraform, while application deployment is fully automated through GitHub Actions.

### End-to-End Workflow

1. The developer pushes application code to the GitHub repository.
2. GitHub Actions automatically starts the Continuous Integration (CI) pipeline.
3. The CI pipeline performs:

   * ESLint code quality checks
   * Jest unit testing
   * npm security audit
   * Docker image build
   * Terraform formatting validation
   * Terraform configuration validation
   * TFLint static analysis
4. If the CI pipeline succeeds, the Continuous Deployment (CD) pipeline starts automatically.
5. GitHub Actions authenticates to Google Cloud using Workload Identity Federation (OIDC), eliminating the need for long-lived service account keys.
6. The Docker image is built and pushed to Google Artifact Registry.
7. Cloud Run deploys a new application revision using the latest container image.
8. Cloud Run securely retrieves database credentials from Google Secret Manager.
9. Cloud Run connects to Cloud SQL through the Serverless VPC Access Connector over a private IP address.
10. Cloud Logging collects application logs, while Cloud Monitoring evaluates metrics and alert policies. Notifications are sent through the configured email notification channel.

---

## Architecture Components

### GitHub

* Stores application source code.
* Maintains Terraform Infrastructure as Code.
* Hosts GitHub Actions workflows.

### GitHub Actions

* Executes the CI/CD pipelines.
* Performs automated testing and validation.
* Builds and publishes Docker images.
* Deploys the latest application version to Cloud Run.

### Terraform

Terraform provisions and manages all cloud infrastructure, including:

* VPC Network
* Subnet
* Serverless VPC Access Connector
* Cloud SQL (MySQL)
* Cloud Run Service
* Artifact Registry
* Secret Manager
* IAM Service Accounts and Role Bindings
* Monitoring Resources
* Logging Resources

### Artifact Registry

Stores versioned Docker images built by the CD pipeline before deployment to Cloud Run.

### Cloud Run

Hosts the containerized Node.js REST API and automatically scales based on incoming traffic.

### Cloud SQL

Provides the managed MySQL database used by the application. The instance is configured with a private IP address to ensure database traffic remains within the Google Cloud network.

### Secret Manager

Stores sensitive information such as database credentials. Secrets are injected securely into Cloud Run during deployment instead of being stored in source code or GitHub.

### Cloud Monitoring & Logging

Provides centralized monitoring, log collection, log-based metrics, and alerting for the deployed application.

---

## DevSecOps Security Controls Implemented

The following security controls were implemented as part of this project:

* Infrastructure provisioned entirely using Terraform.
* Principle of Least Privilege applied through dedicated IAM service accounts.
* Secure authentication from GitHub Actions to Google Cloud using OIDC.
* No service account JSON keys stored in GitHub.
* Database credentials stored in Google Secret Manager.
* Cloud SQL configured with Private IP connectivity.
* Serverless VPC Access Connector used for secure communication between Cloud Run and Cloud SQL.
* Automated code quality validation using ESLint.
* Automated unit testing using Jest.
* Dependency vulnerability checks using npm audit.
* Infrastructure validation using Terraform Validate and TFLint.
* Centralized logging and monitoring using Cloud Logging and Cloud Monitoring.
* Email-based alert notifications configured for operational visibility.


---

# Technology Stack

| Category               | Technology                          |
| ---------------------- | ----------------------------------- |
| Cloud Provider         | Google Cloud Platform (GCP)         |
| Programming Language   | Node.js                             |
| Framework              | Express.js                          |
| Database               | Cloud SQL (MySQL 8.0)               |
| Containerization       | Docker                              |
| Container Registry     | Google Artifact Registry            |
| Compute Platform       | Cloud Run                           |
| Infrastructure as Code | Terraform                           |
| CI/CD                  | GitHub Actions                      |
| Authentication         | Workload Identity Federation (OIDC) |
| Secrets Management     | Google Secret Manager               |
| Monitoring             | Cloud Monitoring                    |
| Logging                | Cloud Logging                       |
| Source Code Repository | GitHub                              |

---

# Project Structure

```text
secure-nodejs-devsecops
│
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── cd.yml
│
├── app/
│   ├── routes/
│   ├── tests/
│   ├── db.js
│   ├── server.js
│   ├── package.json
│   ├── Dockerfile
│   └── .dockerignore
│
├── terraform/
│   ├── provider.tf
│   ├── network.tf
│   ├── cloudsql.tf
│   ├── cloudrun.tf
│   ├── cloudrun-iam.tf
│   ├── iam.tf
│   ├── artifactregistry.tf
│   ├── secretmanager.tf
│   ├── monitoring.tf
│   ├── alerting.tf
│   ├── outputs.tf
│   ├── variable.tf
│   └── terraform.tfvars (local only, not committed)
│
├── README.md
└── .gitignore
```

---

# Infrastructure Provisioned using Terraform

The following Google Cloud resources were provisioned using Terraform.

| Resource                        | Purpose                                                    |
| ------------------------------- | ---------------------------------------------------------- |
| VPC Network                     | Private networking for application components              |
| Subnet                          | Regional subnet for Cloud SQL and VPC Connector            |
| Private Service Connection      | Enables private communication with Google managed services |
| Serverless VPC Access Connector | Secure connectivity from Cloud Run to Cloud SQL            |
| Cloud SQL (MySQL)               | Managed relational database                                |
| Database                        | Application database (`appdb`)                             |
| Database User                   | Dedicated application database user                        |
| Secret Manager Secret           | Secure storage for database password                       |
| Secret Version                  | Stores the latest database password                        |
| Artifact Registry               | Stores Docker images                                       |
| Cloud Run Service               | Hosts the Node.js REST API                                 |
| Cloud Run Service Account       | Dedicated runtime identity                                 |
| IAM Role Bindings               | Least privilege access for Cloud Run                       |
| Logs-Based Metric               | Tracks Cloud Run application errors                        |
| Alert Policy                    | Sends notifications when alert conditions are met          |

---

# Terraform Modules

The Terraform configuration is organized into logical files to improve readability and maintainability.

| File                | Responsibility                                 |
| ------------------- | ---------------------------------------------- |
| provider.tf         | Google provider configuration                  |
| network.tf          | VPC, subnet, private networking, VPC connector |
| cloudsql.tf         | Cloud SQL instance, database and user          |
| secretmanager.tf    | Secret Manager resources                       |
| artifactregistry.tf | Artifact Registry repository                   |
| iam.tf              | IAM roles and permissions                      |
| cloudrun.tf         | Cloud Run service configuration                |
| cloudrun-iam.tf     | Cloud Run IAM policy                           |
| monitoring.tf       | Logs-based metrics                             |
| alerting.tf         | Monitoring alert policies                      |
| outputs.tf          | Terraform outputs                              |
| variable.tf         | Input variables                                |


---

# CI/CD Pipeline

The project implements a secure DevSecOps CI/CD pipeline using GitHub Actions.

The pipeline is divided into two stages:

* Continuous Integration (CI)
* Continuous Deployment (CD)

---

# Continuous Integration (CI)

The CI pipeline is triggered automatically whenever code is pushed to the `main` branch.

## CI Workflow

1. Checkout source code.
2. Install Node.js dependencies.
3. Execute ESLint for code quality validation.
4. Execute Jest unit tests.
5. Run `npm audit` to identify vulnerable packages.
6. Build the Docker image.
7. Execute `terraform fmt` to validate Terraform formatting.
8. Execute `terraform validate` to validate Terraform configuration.
9. Execute TFLint for Infrastructure as Code best-practice validation.

The CI pipeline ensures that only validated and tested code proceeds to deployment.

---

# Continuous Deployment (CD)

The CD pipeline executes automatically after a successful CI run.

The deployment process performs the following tasks:

1. Authenticates GitHub Actions to Google Cloud using Workload Identity Federation (OIDC).
2. Configures Docker authentication for Google Artifact Registry.
3. Builds the latest Docker image.
4. Pushes the image to Artifact Registry.
5. Deploys the latest image to Google Cloud Run.
6. Cloud Run creates a new revision without downtime.

This provides a fully automated deployment process.

---

# GitHub Actions Workflows

| Workflow | Purpose                                                            |
| -------- | ------------------------------------------------------------------ |
| ci.yml   | Code validation, testing, Docker build, Terraform validation       |
| cd.yml   | Build Docker image, push to Artifact Registry and deploy Cloud Run |

---

# Secure Authentication using OIDC

Instead of storing a long-lived Google Cloud service account key in GitHub Secrets, this project uses Workload Identity Federation (OIDC).

The authentication flow is:

1. GitHub Actions requests an OpenID Connect (OIDC) identity token.
2. Google Cloud validates the identity token using the configured Workload Identity Provider.
3. Google Cloud generates a short-lived access token.
4. GitHub Actions uses the temporary credentials to deploy resources.

### Benefits

* No service account JSON keys.
* Short-lived credentials.
* Reduced credential leakage risk.
* Google-recommended authentication mechanism.
* Better compliance with DevSecOps security practices.

---

# Security Best Practices Implemented

The project follows the Principle of Least Privilege and modern DevSecOps practices.

## Identity and Access Management

* Dedicated Cloud Run Service Account.
* Dedicated GitHub Deployment Service Account.
* Minimal IAM roles assigned.
* No Owner or Editor roles used.

## Secret Management

* Database password stored in Google Secret Manager.
* Secrets are injected into Cloud Run at runtime.
* Secrets are never stored in source code.
* Secrets are not committed to GitHub.

## Network Security

* Cloud SQL uses a Private IP address.
* Cloud Run accesses Cloud SQL through a Serverless VPC Access Connector.
* Database traffic remains within the Google Cloud private network.

## Infrastructure as Code

* All cloud resources are provisioned using Terraform.
* Infrastructure changes are version controlled.
* Terraform validation and linting are executed in the CI pipeline.

## Container Security

* Docker image built through GitHub Actions.
* Dependency vulnerability scan performed using `npm audit`.
* Docker image stored securely in Artifact Registry.

---

# Deployment Workflow

```text
Developer
    │
    ▼
Git Push
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions (CI)
    │
    ├── ESLint
    ├── Jest
    ├── npm audit
    ├── Docker Build
    ├── terraform fmt
    ├── terraform validate
    └── TFLint
    │
    ▼
GitHub Actions (CD)
    │
    ▼
OIDC Authentication
    │
    ▼
Artifact Registry
    │
    ▼
Cloud Run
    │
    ▼
Serverless VPC Access Connector
    │
    ▼
Cloud SQL
```
---

# Deployment Steps

## Prerequisites

Before deploying the application, ensure the following tools are installed:

* Google Cloud SDK
* Terraform
* Docker Desktop
* Node.js (LTS Version)
* Git

---

## Clone the Repository

```bash
git clone https://github.com/dhineshkumarcloud/secure-nodejs-devsecops.git

cd secure-nodejs-devsecops
```

---

## Provision Infrastructure

Navigate to the Terraform directory.

```bash
cd terraform
```

Initialize Terraform.

```bash
terraform init
```

Review the execution plan.

```bash
terraform plan
```

Provision the infrastructure.

```bash
terraform apply
```

Terraform provisions:

* VPC Network
* Private Service Connection
* Serverless VPC Access Connector
* Cloud SQL
* Secret Manager
* Artifact Registry
* Cloud Run
* IAM Roles
* Monitoring Resources

---

## Local Application Setup

Navigate to the application directory.

```bash
cd app
```

Install dependencies.

```bash
npm install
```

Run the application.

```bash
npm start
```

---

## CI/CD Deployment

The deployment process is fully automated.

Every push to the `main` branch triggers:

### Continuous Integration

* ESLint
* Jest Unit Tests
* npm audit
* Docker Build
* terraform fmt
* terraform validate
* TFLint

### Continuous Deployment

* OIDC Authentication
* Docker Image Build
* Push Image to Artifact Registry
* Deploy Latest Revision to Cloud Run

No manual deployment steps are required after a successful Git push.

---

# Validation and Testing

The following validations were completed during implementation.

| Validation                 | Status |
| -------------------------- | ------ |
| Node.js Application        | Passed |
| REST API Health Endpoint   | Passed |
| Docker Image Build         | Passed |
| Artifact Registry Push     | Passed |
| Cloud Run Deployment       | Passed |
| Cloud SQL Connectivity     | Passed |
| Secret Manager Integration | Passed |
| GitHub Actions CI          | Passed |
| GitHub Actions CD          | Passed |
| Terraform Validation       | Passed |
| TFLint Validation          | Passed |
| Log-Based Metric Creation  | Passed |
| Monitoring Alert Policy    | Passed |

---

# Monitoring and Alerting

Cloud Monitoring is configured to provide operational visibility into the deployed application.

Implemented monitoring features include:

* Cloud Logging
* Logs-Based Metric
* Monitoring Alert Policy
* Email Notification Channel

Monitoring helps identify application failures and operational issues quickly.

---

# Screenshots

The following screenshots are included with the project submission.

# Screenshots

## Solution Architecture

![Architecture](architecture/architecture-diagram.png)

---

## CI Pipeline

![CI Pipeline](screenshots/01-ci-pipeline-success.png)

---

## CD Pipeline

![CD Pipeline](screenshots/02-cd-pipeline-success.png)

---

## Artifact Registry

![Artifact Registry](screenshots/03-artifact-registry.png)

---

## Cloud Run Deployment

![Cloud Run](screenshots/04-cloud-run-service.png)

---

## Cloud SQL Instance

![Cloud SQL](screenshots/05-cloud-sql-instance.png)

---

## Secret Manager

![Secret Manager](screenshots/06-secret-manager.png)

---

## Logs-Based Metric

![Logs Metric](screenshots/07-logs-based-metric.png)

---

## Monitoring Alert Policy

![Monitoring](screenshots/08-monitoring-alert-policy.png)

---

# Assumptions

The following assumptions were made during implementation.

* Google Cloud APIs are enabled before deployment.
* Required IAM permissions are available.
* The email notification channel is configured before applying monitoring resources.
* Cloud Run is deployed in the selected Google Cloud region.
* Database credentials are stored only in Google Secret Manager.

---

# Future Enhancements

The solution can be further enhanced by implementing:

* Google Chat notification channel
* Trivy container image scanning
* Docker image signing
* Binary Authorization
* Cloud Armor integration
* Custom Cloud Monitoring dashboard
* Remote Terraform state using Google Cloud Storage
* Terraform modules for reusable infrastructure
* Multi-environment deployments (Development, Staging and Production)

---

# Cleanup

To remove all provisioned infrastructure:

```bash
terraform destroy
```

This removes all Terraform-managed resources from the Google Cloud project.

---

# Conclusion

This project demonstrates a complete DevSecOps implementation for deploying a secure containerized Node.js application on Google Cloud Platform.

The solution successfully implements:

* Infrastructure as Code using Terraform
* Secure CI/CD using GitHub Actions
* OIDC-based authentication
* Cloud Run deployment
* Cloud SQL private connectivity
* Secret Manager integration
* Least Privilege IAM
* Logging and Monitoring
* Automated deployment pipeline

The implementation follows modern cloud-native and DevSecOps best practices while providing a secure, scalable, and maintainable deployment architecture.
