variable "portfolio_name" {
  description = "Name of the Service Catalog portfolio"
  type        = string
}

variable "portfolio_description" {
  description = "Portfolio description"
  type        = string
}

variable "provider_name" {
  description = "Provider name"
  type        = string
}

variable "product_name" {
  description = "Service Catalog Product Name"
  type        = string
}

variable "product_owner" {
  description = "Owner of the Service Catalog product"
  type        = string
}

variable "product_description" {
  description = "Description of the Service Catalog product"
  type        = string
}
variable "support_url" {
  type        = string
}
variable "support_email" {
  type        = string
}
variable "artifact_version" {
  description = "Version of the provisioning artifact"
  type        = string
}

variable "template_url" {
  description = "S3 URL for Terraform artifact"
  type        = string
}

variable "launch_role_arn" {
  description = "IAM Role ARN for Service Catalog Launch Constraint"
  type        = string
}

variable "iam_group_arn" {
  type = string
}


# Variable for VPC product name
variable "vpc_product_name" {
  description = "Service Catalog VPC Product Name"
  type        = string
}

# Variable for VPC product owner
variable "vpc_product_owner" {
  description = "Owner of the VPC Service Catalog product"
  type        = string
}

# Variable for VPC product description
variable "vpc_product_description" {
  description = "Description of the VPC Service Catalog product"
  type        = string
}

# Support URL for the VPC product
variable "vpc_support_url" {
  description = "Support URL for the VPC product"
  type        = string
}

# Support email for the VPC product
variable "vpc_support_email" {
  description = "Support email for the VPC product"
  type        = string
}

# Version for the VPC product artifact
variable "vpc_artifact_version" {
  description = "Version of the provisioning artifact for the VPC product"
  type        = string
}

# S3 URL for the VPC product Terraform template
variable "vpc_template_url" {
  description = "S3 URL for Terraform artifact for the VPC product"
  type        = string
}

