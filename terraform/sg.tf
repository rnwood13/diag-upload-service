module "security_group_ecs_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "ECS ALB Security Group"
  description = "Security group for HTTP WebUIs hosted on ECS"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "ECS WebUI HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "security_group_diag_upload_service" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "ECS diag_upload_service ingress/egress Security Group"
  description = "Security group for diag_upload_service hosted on ECS"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 8000
      to_port                  = 8000
      protocol                 = "tcp"
      description              = "diag_upload_service HTTP"
      source_security_group_id = module.security_group_ecs_alb.security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
