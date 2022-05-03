resource "aws_efs_file_system" "diag_upload_service" {
  creation_token   = var.project_name
  encrypted        = true
  performance_mode = var.ecs_efs_string_vars.performance_mode
  throughput_mode  = var.ecs_efs_string_vars.throughput_mode
  lifecycle_policy {
    transition_to_ia = var.ecs_efs_string_vars.transition_to_ia
  }
  tags = {
    "Name" = "${var.project_name} ECS EFS"
  }
}

resource "aws_efs_mount_target" "diag_upload_service" {
  for_each        = toset(module.vpc.private_subnets)
  file_system_id  = aws_efs_file_system.diag_upload_service.id
  subnet_id       = each.value
  security_groups = [module.security_group_diag_upload_service.security_group_id]
}
