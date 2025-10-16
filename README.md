# CIP-001 Infrastructure

---

Terraform-based Infrastructure As Code (IaC) repository for the **CIP-001 Cloud Infrastructure Portfolio Project**. The goal is to provision and manage AWS resources required to securely host a static website and provide a backend for the contact form using Terraform.

This repository contains:
- Terraform code to create the production infrastructure used by the website.
- Example Docker/Docker Compose files to run Terraform in a reproducible container.
- Outputs that surface the S3 bucket name and CloudFront domain for deployment pipelines.

## Overview

The infrastructure provisions the following AWS services:

- Amazon S3
- Amazon CloudFront
- Amazon Route 53
- AWS Certificate Manager (ACM)
- Amazon API Gateway
- AWS Lambda
- Amazon SES (Simple Email Service)

### Configuration

The infrastructure consists of three parts:
1. Infrastructure required by the Terraform backend.
2. Infrastructure needed to host the static website.
3. Infrastructure needed to enable functionality of the contact form.

#### 1. Infrastructure required by the Terraform backend.

Amazon S3 is setup as per the [Terraform Documentation](https://developer.hashicorp.com/terraform/language/backend/s3) in order
to host the terraform state. This bucket is protected by special access required through IAM, multi-factor authenticaiton,
and versioning to prevent any accidental deletes.

#### 2. Infrastructure needed to host the static website.

The website is backend by the following setup:
- **S3 Bucket**: Configured for static website hosting with public read access disabled; access is managed via CloudFront.
- **CloudFront Distribution**: Serves content from S3, enforces HTTPS using ACM certificates.
- **Route 53**: DNS records point your domain to the CloudFront distribution.
- **Amazon Certificate Manager (ACM)**: SSL certificate is provisioned for your domain and validated via DNS.

>The website source code is maintained separately at [github.com/MHooijberg/cip-001_website](https://github.com/MHooijberg/cip-001_website).

#### 3. Infrastructure needed to enable functionality of the contact form.
The contact form on the website is integrated with a serverless backend that consists of:

- **API Gateway** Provides the HTTP endpoint for the website contact form.
- **Lambda function** Handles POST requests from API Gateway, validates and processes form data, and invokes SES.
- **SES** Sends an email containing the contact form data to the sales address (e.g., `sales@cip-001.mhooijberg.com`).
- **Route 53**: DNS records setup for SES.

The process of sending an email through the contact form on the website is as following:

1. **User submits the contact form** on the website.
2. **API Gateway** receives the HTTP POST request from the frontend.
3. **Lambda function** is triggered by API Gateway, validates the form data, and formats the email.
4. **SES** sends the email to the sales address (e.g., `sales@cip-001.mhooijberg.com`).
5. **Lambda** returns a response to the frontend indicating success or failure.

This setup ensures secure, scalable, and cost-effective handling of contact requests without exposing sensitive infrastructure.

>The labmda source code is maintained separately at [github.com/MHooijberg/cip-001_lambda-email-function](https://github.com/MHooijberg/cip-001_lambda-email-function).

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

## Security & operational notes

- S3 buckets are configured to block public access; CloudFront origin access is used to serve content.
- Use ACM in us-east-1 for CloudFront certificates.
- SES may require verification of sending/receiving addresses and region-specific setup.
- Monitor billing and set alerts for SES usage and Lambda invocations.
- Consider adding WAF in front of CloudFront if the site expects higher security requirements or traffic.

## License

This project is licensed under the GPL-3.0 License.

## Further reading & references

- Terraform docs: https://www.terraform.io/docs
- AWS S3 & CloudFront docs: https://docs.aws.amazon.com
- Astro website source: https://github.com/MHooijberg/cip-001_website
- Lambda email function: https://github.com/MHooijberg/cip-001_lambda-email-function

---

Feel free to open issues or pull requests for improvements or questions.

# Todo:
The following tasks should still be done.
- [ ] Add 'configuration and variables' section.
- [ ] Add 'Terraform Outputs' section.
- [ ] Add 'Trouble shooting' section.
