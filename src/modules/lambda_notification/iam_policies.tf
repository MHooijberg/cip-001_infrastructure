resource "aws_iam_policy" "ses_send_email" {
  name        = "lambda-ses-send-email"
  description = "Allow Lambda to send emails through SES"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*" # optionally restrict to your SES identity ARN
      }
    ]
  })
}

