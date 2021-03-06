resource "aws_cloudwatch_log_group" "diag_upload_service" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 14
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

resource "aws_ecs_task_definition" "diag_upload_service" {
  family = "diag_upload_service"

  execution_role_arn = aws_iam_role.diag_upload_service.arn

  container_definitions = jsonencode([
    {
      name              = var.project_name
      image             = "${aws_ecr_repository.diag_upload_service.repository_url}:${var.ecr_image_tag}"
      memoryReservation = 512
      essential         = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      mountPoints = [
        {
          containerPath = "/usr/app/diags"
          sourceVolume  = "ecs-efs"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.vpc_region
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  volume {
    name = "ecs-efs"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.diag_upload_service.id
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999
      root_directory          = "/"
    }
  }

  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"
}

resource "aws_ecs_service" "diag_upload_service" {
  count = var.ecs_enable ? 1 : 0

  name             = "${var.project_name}-service"
  cluster          = aws_ecs_cluster.diag_upload_service.id
  task_definition  = aws_ecs_task_definition.diag_upload_service.arn
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  desired_count    = 2

  network_configuration {
    assign_public_ip = false
    security_groups = [
      module.security_group_diag_upload_service.security_group_id
    ]
    subnets = module.vpc.private_subnets
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = var.project_name
    container_port   = 8000
  }
}
