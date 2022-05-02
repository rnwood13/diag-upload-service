output "ecr_repository_url" {
  value = aws_ecr_repository.diag_upload_service.repository_url
}

output "alb_url" {
  value = var.elb_enable ? "http://${module.alb.lb_dns_name}" : null
}
