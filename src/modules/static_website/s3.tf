resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# S3 bucket (for static website hosting)
resource "aws_s3_bucket" "website" {
  bucket = "${locals.project_domain}_${random_id.bucket_suffix.hex}"
  # allow Terraform to destroy/recreate during testing; remove force_destroy in production if you want to protect objects
  force_destroy = true

  # IMPORTANT: do NOT enable "website" here — we use S3 as a private origin (not a website endpoint)
}

# Block public access (best practice) – use OAC instead
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.website
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Ensure Object Ownership is 'BucketOwnerEnforced' for OAC usage
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.website

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}