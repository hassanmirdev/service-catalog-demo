module "iam_group" {
  source = "../../modules/iam_group"
}

module "iam" {
  source       = "../../modules/iam"
  policy_name  = "EC2ResourceCreationAndArtifactAccessPolicy"
  role_name    = "SCLaunch-EC2product"
}

# Adding a VPC product configuration
module "service_catalog_vpc" {
  source                = "../../modules/service_catalog"
  depends_on            = [module.iam_group, module.iam]
  portfolio_name        = "VPC Portfolio"
  portfolio_description = "Portfolio for VPC configurations"
  provider_name         = "Network Team (network@example.com)"
  product_name          = "VPC_Product"
  product_owner         = "NetworkAdmin"
  product_description   = "Terraform product to provision a Virtual Private Cloud (VPC)."
  support_url           = "https://wiki.example.com/network/support"
  support_email         = "networksupport@example.com"
  artifact_version      = "1.0"
  template_url          = "https://servicecatalogterraform.s3.us-east-1.amazonaws.com/vpc-module.tar.gz"
  launch_role_arn       = module.iam.iam_role_arn
  iam_group_arn         = module.iam_group.iam_group_arn
}

module "service_catalog_ec2" {
  source                = "../../modules/service_catalog"
  depends_on            = [module.iam_group, module.iam]
  portfolio_name        = "EC2 Portfolio"
  portfolio_description = "Portfolio for Terraform configurations"
  provider_name         = "IT (it@example.com)"
  product_name          = "EC2_instanace"
  product_owner         = "Devops"
  product_description   = "Terraform product containing an Amazon EC2."
  support_url           = "https://wiki.example.com/IT/support"
  support_email         = "ITSupport@example.com"
  artifact_version      = "v1.0"
  template_url          = "https://servicecatalogterraform.s3.us-east-1.amazonaws.com/service-catalog_ec2.tar.gz"
  launch_role_arn       = module.iam.iam_role_arn
  iam_group_arn         = module.iam_group.iam_group_arn
}


