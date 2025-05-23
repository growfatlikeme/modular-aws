/*
#see variables.tf for variable definitions in part 1, then locals.tf for local variables
# 2. Request an SSL certificate from ACM
resource "aws_acm_certificate" "cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = {
    Name = "${local.name_prefix}-certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}
*/

# Find the existing hosted zone
data "aws_route53_zone" "parent" {
  name = "sctp-sandbox.com"  # The parent domain
  private_zone = false       # Set to true if it's a private zone
}

/*
# Create DNS validation records in the parent zone
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.parent.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

# Wait for certificate validation
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}


# Create a subdomain record pointing to your ALB
resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.parent.zone_id
  name    = local.domain_name  # e.g., estee-dev.sctp-sandbox.com
  type    = "A"

  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}

*/
# Create a subdomain record pointing to your S3 bucket
# This is for the static website hosted in S3 - see storage module
resource "aws_route53_record" "www" {
 zone_id = data.aws_route53_zone.parent.zone_id
 name = "${local.name_prefix}-s3." # Bucket prefix before sctp-sandbox.com
 type = "A"

 alias {
   name = var.website_configuration_domain
   zone_id = var.hosted_zone_id
   evaluate_target_health = true
 }
}
