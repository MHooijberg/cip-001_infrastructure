resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.website.id

  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Sid": "AllowCloudFrontServicePrincipalReadOnly",
  #       "Effect": "Allow",
  #       "Principal": {
  #         "Service": "cloudfront.amazonaws.com"
  #       },
  #       "Action": "s3:GetObject",
  #       "Resource": "arn:aws:s3:::amzn-s3-demo-bucket/*",
  #       "Condition": {
  #         "StringEquals": {
  #           "AWS:SourceArn": "arn:aws:cloudfront::111122223333:distribution/<CloudFront distribution ID>"
  #         }
  #       }
  #     }
  #   ]
  # }
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.website.id}/*"
        Condition = {
          StringEquals = {
            # Scope to only this distribution
            "AWS:SourceArn" = aws_cloudfront_distribution.cdn.arn
          }
        }
      }
    ]
  })

  # ensure the distribution is created (so its ARN exists) before applying the bucket policy
  depends_on = [aws_cloudfront_distribution.cdn]
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

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


