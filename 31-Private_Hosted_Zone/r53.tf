
# █▀█ █▀█ █░█ ▀█▀ █▀▀   ░█▄░▀██
# █▀▄ █▄█ █▄█ ░█░ ██▄   ░▄█░▄▄█

# Private Hosted Zone
resource "aws_route53_zone" "saafoo_io" {
  name = "saafoo.io"

  vpc {
    vpc_id  = data.aws_vpc.default.id
  }
}

# Dummy www Record
resource "aws_route53_record" "www_saafoo_io" {
  zone_id = aws_route53_zone.saafoo_io.zone_id
  name    = "www.saafoo.io"
  type    = "A"
  ttl     = 60
  records = [ "1.1.1.1" ]
}

# SAA VPC Association
resource "aws_route53_zone_association" "saa_vpc" {
  zone_id = aws_route53_zone.saafoo_io.zone_id
  vpc_id  = module.saa_vpc_1.vpc.id
}

