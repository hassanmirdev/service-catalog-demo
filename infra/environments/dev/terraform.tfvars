products = {
  "EC2" = {
    name             = "EC2"
    owner            = "Devops"
    description      = "Terraform product containing an Amazon EC2."
    support_email    = "ITSupport@example.com"
    support_url      = "https://wiki.example.com/IT/support"
    artifact_version = "v1.0"
    template_url     = "https://servicecatalogterraform.s3.us-east-1.amazonaws.com/service-catalog_ec2.tar.gz"
  }
  "VPC" = {
    name             = "VPC"
    owner            = "Devops"
    description      = "Terraform product containing an Amazon VPC."
    support_email    = "ITSupport@example.com"
    support_url      = "https://wiki.example.com/IT/support"
    artifact_version = "v1.0"
    template_url     = "https://servicecatalogterraform.s3.us-east-1.amazonaws.com/vpc_module.tar.gz"
  }
}
