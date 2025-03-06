output "portfolio_id" {
  value = aws_servicecatalog_portfolio.portfolio.id
}

output "product_ids" {
  value = [for p in aws_servicecatalog_product.product : p.id]
}
