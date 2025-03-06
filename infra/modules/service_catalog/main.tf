# Create Portfolio
resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

# Create ec2 poroduct
resource "aws_servicecatalog_product" "product" {
  name                = var.product_name
  owner               = var.product_owner
  description         = var.product_description
  type                = "EXTERNAL"
  support_email       = var.support_email
  support_url         = var.support_url

  provisioning_artifact_parameters {
    name         = var.artifact_version
    description  = "Initial version"
    type         = "EXTERNAL"
    template_url = var.template_url
    disable_template_validation = true
  }
}

# Create VPC product
resource "aws_servicecatalog_product" "vpc_product" {
  name                = var.vpc_product_name
  owner               = var.vpc_product_owner
  description         = var.vpc_product_description
  type                = "EXTERNAL"
  support_email       = var.support_email
  support_url         = var.support_url

  provisioning_artifact_parameters {
    name         = var.vpc_artifact_version
    description  = "Initial VPC version"
    type         = "EXTERNAL"
    template_url = var.vpc_template_url
    disable_template_validation = true
  }
}

# associate ec2 product with porfolio
resource "aws_servicecatalog_product_portfolio_association" "product_association" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.product.id
}

# Associate the second (VPC) product with the portfolio
resource "aws_servicecatalog_product_portfolio_association" "vpc_product_association" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.vpc_product.id
}


resource "aws_servicecatalog_principal_portfolio_association" "portfolio_access_group" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.iam_group_arn
  principal_type = "IAM"
}

# Launch Constraint for the Ec2 product
resource "aws_servicecatalog_constraint" "launch_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.product.id
  type         = "LAUNCH"

  parameters = jsonencode({
    "RoleArn" = var.launch_role_arn
  })
 depends_on = [var.launch_role_arn]
}

# Launch Constraint for the VPC product
resource "aws_servicecatalog_constraint" "vpc_launch_constraint" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.vpc_product.id
  type         = "LAUNCH"

  parameters = jsonencode({
    "RoleArn" = var.vpc_launch_role_arn
  })
  depends_on = [var.vpc_launch_role_arn]
}

