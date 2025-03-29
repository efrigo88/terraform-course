resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/manually-created-lambda"
  retention_in_days = 7
}
