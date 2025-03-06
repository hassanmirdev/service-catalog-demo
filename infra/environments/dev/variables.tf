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
