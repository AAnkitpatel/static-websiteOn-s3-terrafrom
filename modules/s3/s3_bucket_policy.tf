resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
depends_on = [ aws_s3_bucket_acl.s3_bucket_acl ]
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.s3_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}
