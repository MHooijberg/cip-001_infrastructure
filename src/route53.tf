# Create Route53 alias records (A + AAAA) pointing to CloudFront
resource "aws_route53_record" "alias_a" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = local.domain_name
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_aaaa" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = local.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}
