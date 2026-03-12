# Add custom mail domain records for SES.
resource "aws_route53_record" "mailfrom_mx" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = aws_sesv2_email_identity_mail_from_attributes.mail_from.mail_from_domain
  type     = "MX"
  ttl      = 600
  records = [
    "10 feedback-smtp.eu-north-1.amazonses.com" # TODO: Region is hardcoded.
  ]
}
resource "aws_route53_record" "mailfrom_spf" {
  provider = aws.us_east_1
  zone_id  = data.aws_route53_zone.primary.zone_id
  name     = aws_sesv2_email_identity_mail_from_attributes.mail_from.mail_from_domain
  type     = "TXT"
  ttl      = 600
  records  = ["v=spf1 include:amazonses.com -all"]
}

# DKIM setup for SES
resource "aws_route53_record" "dkim_records" {
  provider = aws.us_east_1
  count    = 3
  # for_each = toset(aws_sesv2_email_identity.mail_domain.dkim_signing_attributes[0].tokens)
  zone_id = data.aws_route53_zone.primary.zone_id
  # name     = "${each.value}._domainkey.${local.computed_domain}"
  type = "CNAME"
  ttl  = 600
  # records  = ["${each.value}.dkim.amazonses.com"]
  name = "${aws_sesv2_email_identity.mail_domain.dkim_signing_attributes[0].tokens[count.index]}._domainkey.${local.computed_domain}"
  records = [
    "${aws_sesv2_email_identity.mail_domain.dkim_signing_attributes[0].tokens[count.index]}.dkim.amazonses.com"
  ]
}