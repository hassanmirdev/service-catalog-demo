variable "products" {
  description = "List of products to create"
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
