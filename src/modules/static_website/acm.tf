# Request ACM certificate in us-east-1 (required for CloudFront)
resource "aws_acm_certificate" "cert" {
  provider          = aws.us_east_1
  domain_name       = local.computed_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Complete certificate validation
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
  depends_on              = [aws_route53_record.cert_validation]
}
