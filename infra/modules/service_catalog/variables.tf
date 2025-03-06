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


variable "launch_role_arn" {
  description = "IAM Role ARN for Service Catalog Launch Constraint"
  type        = string
}

variable "iam_group_arn" {
  type = string
}

variable "products" {
  description = "List of products"
  type = map(object({
    name             = string
    owner            = string
    description      = string
    support_email    = string
    support_url      = string
    artifact_version = string
    template_url     = string
  }))
}
