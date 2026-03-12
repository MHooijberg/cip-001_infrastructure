resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke${var.environment}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.contact_api.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/${var.environment}/*"
}