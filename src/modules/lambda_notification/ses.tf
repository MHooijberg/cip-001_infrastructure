// Route53
resource "aws_sesv2_email_identity" "mail_send_address" {
  email_identity = var.to_address
}

resource "aws_sesv2_email_identity" "mail_domain" {
  email_identity = local.project_domain
  dkim_signing_attributes {
    next_signing_key_length = RSA_2048_BIT
  }
}

resource "aws_sesv2_email_identity_mail_from_attributes" "example" {
  email_identity = aws_sesv2_email_identity.mail_domain.email_identity

  behavior_on_mx_failure = "USE_DEFAULT_VALUE"
  mail_from_domain       = "mail.${aws_sesv2_email_identity.mail_domain.email_identity}"
}