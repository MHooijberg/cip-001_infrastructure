resource "aws_apigatewayv2_route" "mail_send" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /mail/send"
  target    = "integrations/${aws_apigatewayv2_integration.mail_send.id}"
}