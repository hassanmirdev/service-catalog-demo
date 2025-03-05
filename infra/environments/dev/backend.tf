terraform {
  backend "s3" {
    bucket         = "servicecatalogterraform"  
    key            = "Service_catalog_state/development/terraform.tfstate"
    region         = "us-east-1"            
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
