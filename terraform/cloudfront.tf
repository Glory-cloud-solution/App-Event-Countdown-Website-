resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for NeoCloud Event Countdown Site"
}

resource "aws_cloudfront_distribution" "cdn_distribution" {
  enabled             = true
  default_root_object = "index.html"
  comment             = "NeoCloud Event Landing Page CDN - Retry Version"

origin {
  domain_name = aws_s3_bucket.neocloud_event_page.bucket_regional_domain_name
  origin_id   = "s3-origin"

  s3_origin_config {
    origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
  }
}

    


  aliases = ["neocloudapp.site", "www.neocloudapp.site"]

  default_cache_behavior {
    target_origin_id       = "s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    compress = true
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "NeoCloud Event Countdown Distribution"
    Environment = "Production"
  }
}
