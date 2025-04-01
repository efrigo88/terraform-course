resource "random_id" "this" {
  byte_length = 8
}

resource "aws_s3_bucket" "this" {
  bucket = "terraform-cloud-${random_id.this.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}
