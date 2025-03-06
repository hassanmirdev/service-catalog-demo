module "iam_group" {
  source   = "../../modules/iam_group"
  group_name = "DevOps"
}

module "iam" {
  source       = "../../modules/iam"
  policy_name  = "EC2ResourceCreationAndArtifactAccessPolicy"
  role_name    = "SCLaunch-EC2product"
}

module "service_catalog" {
  source                = "../../modules/service_catalog"
  depends_on = [module.iam_group, module.iam]
  portfolio_name        = "EC2 and VPC Portfolio"
  portfolio_description = "A portfolio containing EC2 and VPC products."
  provider_name         = "IT (it@example.com)"
  iam_group_arn         = module.iam_group.iam_group_arn
  products              = var.products
  launch_role_arn       = module.iam.iam_role_arn

}
