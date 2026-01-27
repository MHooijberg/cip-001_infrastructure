resource "aws_apigatewayv2_api" "http_api" {
  name          = "mail-${var.environment}-api"
  protocol_type = "HTTP"
}