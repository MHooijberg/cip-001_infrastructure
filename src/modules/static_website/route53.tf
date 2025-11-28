# Find the hosted zone in Route53 (assumes the zone exists in your account)
data "aws_route53_zone" "primary" {
  provider     = aws.us_east_1
  name         = local.domain_name
  private_zone = false
}

# Create Route53 alias records (A + AAAA) pointing to CloudFront
resource "aws_route53_record" "alias_a" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = local.project_domain
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_aaaa" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = local.project_domain
  type     = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}