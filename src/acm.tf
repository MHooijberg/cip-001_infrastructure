# Request ACM certificate in us-east-1 (required for CloudFront)
resource "aws_acm_certificate" "cert" {
  provider          = aws.us_east_1
  domain_name       =  "${local.project_name}.${local.domain_name}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Find the hosted zone in Route53 (assumes the zone exists in your account)
data "aws_route53_zone" "primary" {
  provider     = aws.us_east_1
  name         = local.domain_name
  private_zone = false
}

# Create the DNS validation records (one per domain_validation_options)
resource "aws_route53_record" "cert_validation" {
  provider = aws.us_east_1
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.value]
}

# Complete certificate validation
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
  depends_on              = [aws_route53_record.cert_validation]
}
