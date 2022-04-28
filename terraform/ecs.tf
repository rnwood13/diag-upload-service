resource "aws_cloudwatch_log_group" "diag_upload_service" {
  name = "var.project_name"
}

resource "aws_ecs_cluster" "diag_upload_service" {
  name = var.project_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.diag_upload_service.name
      }
    }
  }
}

