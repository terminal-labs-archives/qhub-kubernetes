output "nginx_ingress_endpoint" {
  description = "Nginx ingress endpoint"
  value       = module.kubernetes-ingress.endpoint
}
