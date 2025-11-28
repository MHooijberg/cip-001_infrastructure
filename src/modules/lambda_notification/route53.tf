# Find the hosted zone in Route53 (assumes the zone exists in your account)
data "aws_route53_zone" "primary" {
  provider     = aws.us_east_1
  name         = local.domain_name
  private_zone = false
}

# Add the TXT verification record to Route53 for SES.
resource "aws_route53_record" "ses_verification" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = "_amazonses.${aws_ses_domain_identity.domain.domain}"
  type     = "TXT"
  ttl      = 600
  records  = [aws_ses_domain_identity.domain.verification_token]
}

# Add custom mail domain records for SES.
resource "aws_route53_record" "mailfrom_mx" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = aws_ses_domain_mail_from.mailfrom.mail_from_domain
  type     = "MX"
  ttl      = 600
  records = [
    "10 feedback-smtp.eu-north-1.amazonses.com"
  ]
}
resource "aws_route53_record" "mailfrom_spf" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = aws_ses_domain_mail_from.mailfrom.mail_from_domain
  type    = "TXT"
  ttl     = 600
  records = ["v=spf1 include:amazonses.com -all"]
}

# DKIM setup for SES
resource "aws_route53_record" "dkim_records" {
  for_each = toset(aws_sesv2_email_identity.mail_domain.dkim_signing_attributes[0].tokens)
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = "${each.value}._domainkey.${local.project_domain}"
  type     = "CNAME"
  ttl      = 600
  records  = ["${each.value}.dkim.amazonses.com"]
}