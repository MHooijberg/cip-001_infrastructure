resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  # Note: AWS added GitHub to one if its many root certificate authorities (CAs), no thumbprint is required anymore.
}

# IAM Role for the terraform repository.
resource "aws_iam_role" "github-actions-infrastructure-deploy-role" {
  name = "github-actions-infrastructure-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            # restrict to specific repo(s) or branch(es) for safety
            "token.actions.githubusercontent.com:sub" = "repo:MHooijberg/cip-001_infrastructure:ref:refs/heads/prod"
          }
        }
      }
    ]
  })
  # then attach permissions/policies for what you need e.g. S3 deploy, Terraform apply, etc.
}

# IAM Role for the lambda repository.
resource "aws_iam_role" "github-actions-lambda-deploy-role" {
  name = "github-actions-lambda-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            # restrict to specific repo(s) or branch(es) for safety
            "token.actions.githubusercontent.com:sub" = "repo:MHooijberg/cip-001_lambda-email-function:ref:refs/heads/prod"
          }
        }
      }
    ]
  })
  # then attach permissions/policies for what you need e.g. S3 deploy, Terraform apply, etc.
}

# IAM Role for the website repository.
resource "aws_iam_role" "github-actions-website-deploy-role" {
  name = "github-actions-website-deploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            # restrict to specific repo(s) or branch(es) for safety
            "token.actions.githubusercontent.com:sub" = "repo:MHooijberg/cip-001_website:ref:refs/heads/prod"
          }
        }
      }
    ]
  })
  # then attach permissions/policies for what you need e.g. S3 deploy, Terraform apply, etc.
}