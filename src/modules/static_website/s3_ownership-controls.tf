# Ensure Object Ownership is 'BucketOwnerEnforced' for OAC usage
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.website

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}