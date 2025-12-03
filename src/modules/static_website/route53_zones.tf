# Find the hosted zone in Route53 (assumes the zone exists in your account)
data "aws_route53_zone" "primary" {
  provider     = aws.us_east_1
  name         = var.domain_name
  private_zone = false
}