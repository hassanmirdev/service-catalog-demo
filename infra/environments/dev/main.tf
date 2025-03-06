module "iam_group" {
  source   = "../../modules/iam_group"
  group_name = "DevOps"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "iam" {
  source       = "../../modules/iam"
  policy_name  = "EC2ResourceCreationAndArtifactAccessPolicy"
  role_name    = "SCLaunch-EC2product"
}

module "service_catalog" {
  source                = "../../modules/service_catalog"
  portfolio_name        = "MyServiceCatalogPortfolio"
  portfolio_description = "A portfolio containing EC2 and VPC products."
  provider_name         = "Your Provider Name"
  iam_group_arn         = module.iam_group.iam_group_arn

  products = {
    ec2_product = {
      product_name        = "EC2_Instance"
      product_owner       = "DevOps"
      product_description = "Terraform product containing an EC2 instance."
      support_email       = "support@example.com"
      support_url         = "https://example.com/support"
      artifact_version    = "v1.0"
      template_url        = "https://s3.amazonaws.com/your-bucket/service-catalog_ec2.tar.gz"
      launch_role_arn     = "arn:aws:iam::180294181827:role/service-catalog-ec2-launch-role"
    },
    vpc_product = {
      product_name        = "VPC_Product"
      product_owner       = "NetworkTeam"
      product_description = "Terraform product containing a VPC."
      support_email       = "network-support@example.com"
      support_url         = "https://example.com/network-support"
      artifact_version    = "v1.0"
      template_url        = "https://s3.amazonaws.com/your-bucket/vpc_module.tar.gz"
      launch_role_arn     = "arn:aws:iam::180294181827:role/service-catalog-vpc-launch-role"
    }
  }
}
