output "static-website-endpoint" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "The endpoint of the static website hosted on S3"
}