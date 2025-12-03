# Request ACM certificate in us-east-1 (required for CloudFront)
resource "aws_acm_certificate" "cert" {
  provider          = aws.us_east_1
  domain_name       = "${local.project_name}.${local.project_domain}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}