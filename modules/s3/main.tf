#create s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucketName
  
}
#enable versioning
resource "aws_s3_bucket_versioning" "s3_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#ow
resource "aws_s3_bucket_public_access_block" "public_s3" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_bucket_ownership,
    aws_s3_bucket_public_access_block.public_s3,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "s3_object" {
  depends_on   = [aws_s3_bucket_policy.bucket_policy]
  for_each     = fileset("./website/", "**") #push all files under the website dir
  bucket       = aws_s3_bucket.s3_bucket.id
  key          = each.value
  source       = "./website/${each.value}"
  content_type = "text/html"
  etag         = filemd5("./website/${each.value}")
}


resource "aws_s3_bucket_website_configuration" "s3_website_config" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

