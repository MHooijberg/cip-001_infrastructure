# Block public access (best practice) – use OAC instead
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.lambda
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}