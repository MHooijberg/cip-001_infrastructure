resource "aws_apigatewayv2_api" "http_api" {
  name          = "mail-${var.environment}-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = [
      "*",
      "https://mhooijberg.com",
    ]
    allow_methods = ["POST", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
  }
}