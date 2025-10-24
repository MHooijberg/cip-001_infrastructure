resource "aws_apigatewayv2_api" "http_api" {
    name          = "mail-api"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "prod" {
    api_id      = aws_apigatewayv2_api.http_api.id
    name        = "prod"
    auto_deploy = true
}

resource "aws_apigatewayv2_stage" "dev" {
    api_id      = aws_apigatewayv2_api.http_api.id
    name        = "dev"
    auto_deploy = true
}

resource "aws_lambda_permission" "apigw_prod" {
    statement_id  = "AllowAPIGatewayInvokeProd"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cip-001_contact_api.arn
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/prod/*"
}

resource "aws_lambda_permission" "apigw_dev" {
    statement_id  = "AllowAPIGatewayInvokeDev"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cip-001_contact_api.arn
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/dev/*"
}

resource "aws_apigatewayv2_integration" "mail_send" {
    api_id                 = aws_apigatewayv2_api.http_api.id
    integration_type       = "AWS_PROXY"
    integration_uri        = aws_lambda_function.cip-001_contact_api.invoke_arn
    integration_method     = "POST"
    payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "mail_send" {
    api_id    = aws_apigatewayv2_api.http_api.id
    route_key = "POST /mail/send"
    target    = "integrations/${aws_apigatewayv2_integration.mail_send.id}"
}

