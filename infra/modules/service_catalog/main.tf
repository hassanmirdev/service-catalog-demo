resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

resource "aws_servicecatalog_product" "product" {
  for_each = var.products

  name                = each.value.name
  owner               = each.value.owner
  description         = each.value.description
  type                = "EXTERNAL"
  support_email       = each.value.support_email
  support_url         = each.value.support_url

  provisioning_artifact_parameters {
    name         = each.value.artifact_version
    description  = "Initial version"
    type         = "EXTERNAL"
    template_url = each.value.template_url
    disable_template_validation = true
  }
}

resource "aws_servicecatalog_product_portfolio_association" "product_association" {
  for_each = aws_servicecatalog_product.product

  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = each.value.id
}

resource "aws_servicecatalog_principal_portfolio_association" "portfolio_access_group" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.iam_group_arn
  principal_type = "IAM"
}

resource "aws_servicecatalog_constraint" "launch_constraint" {
  for_each = aws_servicecatalog_product.product

  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = each.value.id
  type         = "LAUNCH"

  parameters = jsonencode({
    "RoleArn" = var.launch_role_arn
  })
}
