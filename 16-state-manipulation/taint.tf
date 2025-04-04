# To taint this S3 bucket and force recreation on next apply, run:
# terraform taint aws_s3_bucket.tainted
resource "aws_s3_bucket" "tainted" {
  bucket = "my-tainted-bucket-3478236"
}

resource "aws_s3_bucket_public_access_block" "from_tainted" {
  bucket = aws_s3_bucket.tainted.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.0.0/24"
}
