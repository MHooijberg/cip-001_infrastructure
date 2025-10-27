resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "cip-001_contact_api" {
  function_name = "my_lambda_function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "src/index.handler"
  runtime       = "nodejs22.x"

  environment {
    variables = {
      TO_ADDRESS   = local.to_address
      FROM_ADDRESS = local.from_address # TODO: use custom mail domain.
    }
  }
}