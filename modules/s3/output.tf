output "website_bucket_domain_name" {
  value = "http://${aws_s3_bucket.s3_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
}
