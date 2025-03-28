# removed {
#   from = aws_s3_bucket.my_bucket

#   lifecycle {
#     destroy = false
#   }
# }

resource "aws_s3_bucket" "my_bucket" {
  bucket = "random-name-4349348274372864"
}
