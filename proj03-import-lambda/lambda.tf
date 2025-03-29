# This Lambda function configuration was generated using:
# terraform plan -generate-config-out=generated.tf
# to import the manually created Lambda function from AWS

# import {
#   to = aws_lambda_function.this
#   id = "manually-created-lambda"
# }

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.root}/build/lambda_function.py"
  output_path = "${path.root}/build/lambda_function.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = "manually-created-lambda"
  description      = "A starter AWS Lambda function."
  architectures    = ["x86_64"]
  filename         = data.archive_file.lambda_zip.output_path
  handler          = "lambda_function.lambda_handler"
  package_type     = "Zip"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.10"
  skip_destroy     = false
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world-python"
  }

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lambda_logs.name
  }
}

resource "aws_lambda_function_url" "this" {
  function_name      = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}
