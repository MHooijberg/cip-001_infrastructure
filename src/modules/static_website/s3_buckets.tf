resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 bucket (for static website hosting)
resource "aws_s3_bucket" "website" {
  bucket = "${local.computed_domain}-${random_id.bucket_suffix.hex}"
  # allow Terraform to destroy/recreate during testing; remove force_destroy in production if you want to protect objects
  force_destroy = true

  # IMPORTANT: do NOT enable "website" here — we use S3 as a private origin (not a website endpoint)
}