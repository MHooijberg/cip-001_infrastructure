
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "attach_ses" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.ses_send_email.arn
}