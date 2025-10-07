# Dockerfile
FROM hashicorp/terraform:1.9.8

# Optional: install extra tools
RUN apk add --no-cache aws-cli jq
