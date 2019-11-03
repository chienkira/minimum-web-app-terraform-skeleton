# Storage for file uploading
resource "aws_s3_bucket" "statics_bucket" {
  bucket = "greatapp-files-${var.env}"
  acl    = "public-read"
  policy = <<EOF
{
  "Id": "bucket_policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::greatapp-files-${var.env}/*",
      "Principal": "*"
    }
  ]
}
EOF
}
