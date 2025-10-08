# CIP-001 Infrastructure

This repository contains the Infrastructure as Code (IaC) configuration for the **CIP-001 Cloud Infrastructure Portfolio Project**. The goal is to provision and manage AWS resources required to securely host a static website and provide a backend for the contact form using Terraform.

## Overview

The infrastructure provisions the following AWS services:

- **Amazon S3**: Hosts the static website files.
- **Amazon CloudFront**: Provides a global CDN for fast and secure content delivery.
- **Amazon Route 53**: Manages DNS records for the website domain.
- **AWS Certificate Manager (ACM)**: Issues and manages SSL/TLS certificates for HTTPS.
- **Amazon API Gateway**: Receives HTTP requests from the website contact form.
- **AWS Lambda**: Processes contact form submissions and triggers email sending.
- **Amazon SES (Simple Email Service)**: Sends emails to the sales address when a contact form is submitted.

>The website source code is maintained separately at [github.com/MHooijberg/cip-001_website](https://github.com/MHooijberg/cip-001_website).

>The website source code is maintained separately at [github.com/MHooijberg/cip-001_lambda-email-function](https://github.com/MHooijberg/cip-001_lambda-email-function).

## Repository Structure

```
root/
├── src/
│   ├── .terraform.lock.hcl   # Terraform's lock file.
│   ├── acm.tf                # Infrastructure as Code definition of Amazon Certificate Manager.
│   ├── backend.tf            # Contains the backend configuration, such as the state manager setup.
│   ├── cloudfront.tf         # Infrastructure as Code definition of 
│   ├── local.tf              # Contains local variables.
│   ├── main.tf               # Core Terraform configuration, contains settings and providers.
│   ├── outputs.tf            # Outputs after deployment
│   ├── policy.tf             # Infrastructure as Code definition of CloudFront service policy.
│   ├── route53.tf            # Infrastructure as Code definition of Route53.
│   ├── s3.tf                 # Infrastructure as Code definition of Amazon Simple Storage Service (S3).
│   └── variables.tf          # Input variables for customization
├── .gitignore                # Git Ignore file, tells git which files to exclude (and optionally include).
├── docker-compose.yml        # Project Docker Compose file, used for running Terraform commands within a container.
├── Dockerfile                # Project Dockerfile containing Terraform and AWS CLIv2.
├── LICENSE                   # Project license.
└── README.md                 # Project documentation.
```

## Current Configuration

- **Region**: AWS region is configurable via `variables.tf`.
- **S3 Bucket**: Configured for static website hosting with public read access disabled; access is managed via CloudFront.
- **CloudFront Distribution**: Serves content from S3, enforces HTTPS using ACM certificates.
- **Route 53**: DNS records point your domain to the CloudFront distribution.
- **ACM**: SSL certificate is provisioned for your domain and validated via DNS.
- **API Gateway**: Provides a REST endpoint for the website contact form.
- **Lambda**: Handles POST requests from API Gateway, validates and processes form data, and invokes SES.
- **SES**: Sends an email containing the contact form data to the configured sales email address.

## Contact Form Backend Architecture

The contact form on the website is integrated with a serverless backend:

1. **User submits the contact form** on the website.
2. **API Gateway** receives the HTTP POST request from the frontend.
3. **Lambda function** is triggered by API Gateway, validates the form data, and formats the email.
4. **SES** sends the email to the sales address (e.g., `sales@mhooijberg.com`).
5. **Lambda** returns a response to the frontend indicating success or failure.

This setup ensures secure, scalable, and cost-effective handling of contact requests without exposing sensitive infrastructure.

## Getting Started

1. **Clone this repository**  
    ```sh
    git clone https://github.com/MHooijberg/cip-001_infrastructure.git
    cd cip-001_infrastructure
    ```

2. **Configure variables**  
    Edit `variables.tf` to set your domain name, AWS region, and sales email address.

3. **Initialize Terraform**  
    ```sh
    docker compose run --rm terraform init
    ```

4. **Plan the configuration**  
    ```sh
    docker compose run --rm terraform plan
    ```

5. **Apply the configuration**  
    ```sh
    docker compose run --rm terraform apply
    ```

## Website Source

Find the website code at [github.com/MHooijberg/cip-001_website](https://github.com/MHooijberg/cip-001_website).

## License

This project is licensed under the MIT License.

---

Feel free to open issues or pull requests for improvements or questions.