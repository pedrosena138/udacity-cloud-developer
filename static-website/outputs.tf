output "bucket_info" {
  description = "Information about the S3 bucket"
  value = {
    id   = aws_s3_bucket.static_website.id
    name = aws_s3_bucket.static_website.bucket
    arn  = aws_s3_bucket.static_website.arn
  }
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.static_website.domain_name
}
