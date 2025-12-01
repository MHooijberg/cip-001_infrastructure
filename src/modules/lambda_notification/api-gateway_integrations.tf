resource "aws_apigatewayv2_integration" "mail_send" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.cip-001_contact_api.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}