output "cloudfront_domain" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "website_bucket" {
  value = aws_s3_bucket.marketing_website.bucket
}

output "site_url" {
  value = "https://${local.domain_name}/"
}
