resource "aws_lambda_permission" "apigw_prod" {
  statement_id  = "AllowAPIGatewayInvokeProd"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.contact_api.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/prod/*"
}

resource "aws_lambda_permission" "apigw_dev" {
  statement_id  = "AllowAPIGatewayInvokeDev"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.contact_api.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/dev/*"
}