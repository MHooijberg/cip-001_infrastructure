resource "aws_lambda_function" "contact_api" {
  function_name = "${var.project_name}_contact_api"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "src/index.handler"
  runtime       = "nodejs22.x"

  environment {
    variables = {
      TO_ADDRESS   = var.to_address
      FROM_ADDRESS = local.from_address
      ENVIRONMENT = var.environment
    }
  }
}