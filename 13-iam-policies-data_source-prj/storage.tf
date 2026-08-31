# IAM policy document for S3 bucket public read access
# Allows any principal to perform GetObject action on all objects in the bucket
data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.dev_bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

# S3 bucket for the dev environment
# Name is suffixed with a random hex value to avoid global bucket-name collisions
resource "aws_s3_bucket" "dev_bucket" {
  bucket = "dev-bucket-${random_id.bucket_suffix.hex}"

}

# Disables all S3 account/bucket-level public access blocking
# Required here because the bucket policy above grants public read access;
# without disabling these blocks, AWS would reject the public policy
resource "aws_s3_bucket_public_access_block" "dev_bucket" {
  bucket = aws_s3_bucket.dev_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Attaches the public-read IAM policy document to the bucket
# depends_on ensures the public access block is lifted before the policy is applied,
# since applying a public policy while the block is active would fail
resource "aws_s3_bucket_policy" "aws_s3_bucket_policy" {
  bucket     = aws_s3_bucket.dev_bucket.id
  policy     = data.aws_iam_policy_document.s3_bucket_policy.json
  depends_on = [aws_s3_bucket_public_access_block.dev_bucket]
}


# Generates a random hex suffix used to make the bucket name globally unique
resource "random_id" "bucket_suffix" {
  byte_length = 6
}

