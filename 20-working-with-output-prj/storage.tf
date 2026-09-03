# Write a S3 bucket configuration for AWS.
# resource "aws_s3_bucket" "example" {
#   bucket = aws_s3_bucket.random.bucket

#   tags = merge(local.common_tags, var.additional_tags)
# }

# Write a resource that randomly generates an S3 bucket name
resource "aws_s3_bucket" "project_bucket" {
  bucket = "${local.common_tags.project}-${random_id.bucket_id.hex}"

  tags = merge(local.common_tags, var.additional_tags)

}

resource "random_id" "bucket_id" {
  byte_length = 4
}
