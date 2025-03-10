/* resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

# Create the first tag option for "ec2"
resource "aws_servicecatalog_tag_option" "ec2_tag" {
  key   = "service"
  value = "ec2"
}

# Create the second tag option for "vpc"
resource "aws_servicecatalog_tag_option" "vpc_tag" {
  key   = "service"
  value = "vpc"
}

# Associate the Tag Options with the Portfolio
resource "aws_servicecatalog_tag_option_resource_association" "ec2_tag_association" {
  resource_id   = aws_servicecatalog_portfolio.portfolio.id
  tag_option_id = aws_servicecatalog_tag_option.ec2_tag.id
}

resource "aws_servicecatalog_tag_option_resource_association" "vpc_tag_association" {
  resource_id   = aws_servicecatalog_portfolio.portfolio.id
  tag_option_id = aws_servicecatalog_tag_option.vpc_tag.id
}

*/

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

# Create Tag Options dynamically using for_each
resource "aws_servicecatalog_tag_option" "tag_options" {
  for_each = var.tag_options

  key   = each.value
  value = each.key
}

# Associate each tag option with the portfolio
resource "aws_servicecatalog_tag_option_resource_association" "tag_option_associations" {
  for_each = aws_servicecatalog_tag_option.tag_options

  resource_id   = aws_servicecatalog_portfolio.portfolio.id
  tag_option_id = each.value.id
}

# Service Action - Restart EC2 Instance
resource "aws_servicecatalog_service_action" "example" {
  description = "Restart EC2 Instance"
  name        = "RestartEC2Instance"
  

  definition {
    name = "AWS-RestartEC2Instance"
    version     = 1
  }
}

/*
# Associate the Service Action with Products
resource "aws_servicecatalog_service_action_association" "action_association" {
  for_each = aws_servicecatalog_product.product

  service_action_id = aws_servicecatalog_service_action.example.id
  product_id        = each.value.id
}
*/


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
