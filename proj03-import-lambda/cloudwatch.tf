# This CloudWatch log group configuration was generated using:
# terraform plan -generate-config-out=generated.tf
# to import the manually created log group from AWS

# import {
#   to = aws_cloudwatch_log_group.lambda_logs
#   id = "/aws/lambda/manually-created-lambda"
# }

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/manually-created-lambda"
  retention_in_days = 7
}
