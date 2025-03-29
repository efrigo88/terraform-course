import {
  to = aws_lambda_function.this
  id = "manually-created-lambda"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.root}/build/lambda_function.py"
  output_path = "${path.root}/build/lambda_function.zip"
}

resource "aws_lambda_function" "this" {
  architectures    = ["x86_64"]
  description      = "A starter AWS Lambda function."
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "manually-created-lambda"
  handler          = "lambda_function.lambda_handler"
  package_type     = "Zip"
  role             = "arn:aws:iam::140023373701:role/service-role/manually-created-lambda-role-6smistj6"
  runtime          = "python3.10"
  skip_destroy     = false
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = {
    "lambda-console:blueprint" = "hello-world-python"
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/manually-created-lambda"
  }
}
