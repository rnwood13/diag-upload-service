variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "MyProject"
}

variable "vpc_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_name" {
  description = "Name of the custom VPC for this project"
  type        = string
  default     = "MyVPC"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones to use"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "vpc_private_subnets" {
  description = "CIDR networks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  description = "CIDR networks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Whether to enable the NAT Gateway"
  type        = bool
  default     = false
}

variable "vpc_enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway"
  type        = bool
  default     = false
}

variable "ecs_enable" {
  description = "Whether to enable and deploy ECS"
  type        = bool
  default     = false
}

variable "elb_enable" {
  description = "Whether to enable Elastic Load Balancer"
  type        = bool
  default     = false
}

variable "ecr_image_tag" {
  description = "Default image tag - will be overwritten in CI"
  type        = string
  default     = "latest"
}
