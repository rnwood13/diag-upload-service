# Remote state assumes DynamoDB and the S3 bucket
# are already deployed, so if this is the first time 
# running Terraform, uncomment the following local
# backend the first time, then delete or comment it, 
# then uncomment the S3 backend, migrate state, 
# and reapply

# terraform {
#   backend "local" {}
# }

terraform {
  backend "s3" {
    bucket         = "rwood13-diag-upload-service-terraform-state-backend"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "rwood13-diag-upload-service_terraform_state"
    encrypt        = true
  }
}
