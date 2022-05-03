project_name           = "rwood13-diag-upload-service"
vpc_region             = "us-east-2"
vpc_name               = "diag-upload-service"
vpc_cidr               = "10.0.0.0/16"
vpc_azs                = ["us-east-2a", "us-east-2b", "us-east-2c"]
vpc_private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
vpc_enable_vpn_gateway = false
vpc_enable_nat_gateway = true
ecs_enable             = true
elb_enable             = true
ecs_efs_string_vars = {
  performance_mode = "generalPurpose",
  throughput_mode  = "bursting",
  transition_to_ia = "AFTER_30_DAYS",
}
