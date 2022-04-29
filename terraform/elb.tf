module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  create_lb = true

  name = "${var.project_name}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.security_group_ecs_alb.security_group_id]

  # access_logs = {
  #   bucket  = "${lower(var.project_name)}-alb-logs"
  #   enabled = true
  # }

  target_groups = [
    {
      name_prefix      = "diag-"
      backend_protocol = "HTTP"
      backend_port     = 8000
      target_type      = "ip"

      # health_check = {
      #   enabled             = true
      #   interval            = 5
      #   path                = "/status"
      #   port                = "traffic-port"
      #   healthy_threshold   = 2
      #   unhealthy_threshold = 2
      #   timeout             = 2
      #   protocol            = "HTTPS"
      # }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}
