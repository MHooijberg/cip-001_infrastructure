# CIP-001 Infrastructure

This repository contains the Infrastructure as Code (IaC) configuration for the **CIP-001 Cloud Infrastructure Portfolio Project**. The goal is to provision and manage AWS resources required to securely host a static website using Terraform.

## Overview

The infrastructure provisions the following AWS services:

- **Amazon S3**: Hosts the static website files.
- **Amazon CloudFront**: Provides a global CDN for fast and secure content delivery.
- **Amazon Route 53**: Manages DNS records for the website domain.
- **AWS Certificate Manager (ACM)**: Issues and manages SSL/TLS certificates for HTTPS.

The website source code is maintained separately at [github.com/MHooijberg/cip-001_website](https://github.com/MHooijberg/cip-001_website).

## Repository Structure

```
.
├── main.tf              # Core Terraform configuration
├── variables.tf         # Input variables for customization
├── outputs.tf           # Outputs after deployment
├── providers.tf         # AWS provider setup
├── README.md            # Project documentation
└── modules/             # (Optional) Reusable Terraform modules
```

## Current Configuration

- **Region**: AWS region is configurable via `variables.tf`.
- **S3 Bucket**: Configured for static website hosting with public read access disabled; access is managed via CloudFront.
- **CloudFront Distribution**: Serves content from S3, enforces HTTPS using ACM certificates.
- **Route 53**: DNS records point your domain to the CloudFront distribution.
- **ACM**: SSL certificate is provisioned for your domain and validated via DNS.

## Getting Started

1. **Clone this repository**  
    ```sh
    git clone https://github.com/MHooijberg/cip-001_infrastructure.git
    cd cip-001_infrastructure
    ```

2. **Configure variables**  
    Edit `variables.tf` to set your domain name and AWS region.

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