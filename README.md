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