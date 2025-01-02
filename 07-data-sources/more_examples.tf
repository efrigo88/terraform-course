data "aws_caller_identity" "current" {}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

##
data "aws_region" "current" {}

output "aws_region" {
  value = data.aws_region.current
}

##
data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "Prod"
  }
}

output "prod_vpc" {
  value = data.aws_vpc.prod_vpc.id
}

##
data "aws_availability_zones" "available" {
  state = "available"
}

output "available_azs" {
  value = data.aws_availability_zones.available
}

##
resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "my-public-read-bucket-kncjksandasx"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${"aws_s3_bucket.public_read_bucket.arn"}/*"]
  }
}

output "bucket_policy" {
  value = data.aws_iam_policy_document.static_website.json
}
