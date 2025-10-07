resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.marketing_website.id

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
        Resource = "arn:aws:s3:::${aws_s3_bucket.marketing_website.id}/*"
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