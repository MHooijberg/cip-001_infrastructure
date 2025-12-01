resource "aws_apigatewayv2_api" "http_api" {
  name          = "mail-api"
  protocol_type = "HTTP"
}