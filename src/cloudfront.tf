# Create an Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${local.project_domain}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always" # recommended: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control?utm_source=chatgpt.com#signing_behavior-1
  signing_protocol                  = "sigv4"
  description                       = "OAC for ${local.project_domain} S3 origin"
}

# CloudFront distribution
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CDN for ${local.project_domain}"
  default_root_object = "index.html"

  aliases = [local.project_domain]

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.website.id}"

    # Link the OAC to origin (secure access)
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.website.id}"

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    # common cache policy + origin request policy can be used; using defaults here
    # TODO: forwarded_values is depricated and is going to be removed in the next major version.
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  # If this is a SPA, return index.html for 403/404 so client routing works
  dynamic "custom_error_response" {
    for_each = local.enable_index_fallback ? [1] : []
    content {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 0
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Use ACM cert from us-east-1 (created later)
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  depends_on = [
    aws_acm_certificate_validation.cert_validation
  ]
}