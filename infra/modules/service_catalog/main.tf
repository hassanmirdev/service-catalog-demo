resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

# Create Products (EC2 and VPC) dynamically using for_each
resource "aws_servicecatalog_product" "product" {
  for_each = var.products

  name          = each.value.product_name
  owner         = each.value.product_owner
  description   = each.value.product_description
  type          = "EXTERNAL"
  support_email = each.value.support_email
  support_url   = each.value.support_url

  provisioning_artifact_parameters {
    name         = each.value.artifact_version
    description  = "Initial version"
    type         = "EXTERNAL"
    template_url = each.value.template_url
    disable_template_validation = true
  }
}

# Associate Products with Portfolio dynamically
resource "aws_servicecatalog_product_portfolio_association" "product_association" {
  for_each = aws_servicecatalog_product.product

  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = each.value.id
}

# Associate the IAM Group with Portfolio
resource "aws_servicecatalog_principal_portfolio_association" "portfolio_access_group" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.iam_group_arn
  principal_type = "IAM"
}

# Launch Constraints for each Product dynamically
resource "aws_servicecatalog_constraint" "launch_constraint" {
  for_each = aws_servicecatalog_product.product

  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = each.value.id
  type         = "LAUNCH"

  parameters = jsonencode({
    "RoleArn" = each.value.launch_role_arn
  })

  depends_on = [each.value.launch_role_arn]
}
