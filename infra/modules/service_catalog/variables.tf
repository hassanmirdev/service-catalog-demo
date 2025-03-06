variable "portfolio_name" {
  description = "The name of the Service Catalog portfolio."
  type        = string
}

variable "portfolio_description" {
  description = "Description of the Service Catalog portfolio."
  type        = string
}

variable "provider_name" {
  description = "Name of the provider for the Service Catalog."
  type        = string
}

variable "launch_role_arn" {
  description = "IAM Role ARN for Service Catalog Launch Constraint"
  type        = string
}
variable "iam_group_arn" {
  description = "IAM Group ARN that will be associated with the portfolio."
  type        = string
}

variable "products" {
  description = "A map of products to create in the Service Catalog."
  type = map(object({
    product_name        : string
    product_owner       : string
    product_description : string
    support_email       : string
    support_url         : string
    artifact_version    : string
    template_url        : string
    launch_role_arn     : string
  }))
}
