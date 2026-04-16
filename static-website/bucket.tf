resource "aws_s3_bucket" "static_website" {
  bucket = "static-website-20260410"

  force_destroy = true

  provisioner "local-exec" {
    command = "bash upload_files.sh ${self.bucket}"
    when    = create
  }
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  depends_on              = [aws_s3_bucket.static_website]
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_website" {
  depends_on = [aws_s3_bucket.static_website]
  bucket     = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AddPerm"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.static_website.arn}/*"]
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  depends_on = [aws_s3_bucket.static_website]
  bucket     = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}
