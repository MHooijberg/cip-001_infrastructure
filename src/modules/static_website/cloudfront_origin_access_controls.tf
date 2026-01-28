# Create an Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${local.computed_domain}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always" # recommended: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control?utm_source=chatgpt.com#signing_behavior-1
  signing_protocol                  = "sigv4"
  description                       = "OAC for ${local.computed_domain} S3 origin"
}