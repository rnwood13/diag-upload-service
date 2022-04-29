resource "aws_s3_bucket" "terraform_state" {
  bucket = "${lower(var.project_name)}-terraform-state-backend"

  object_lock_enabled = true

  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# resource "aws_s3_bucket" "diag_upload_service_alb_logs" {
#   bucket = "${lower(var.project_name)}-alb-logs"

#   tags = {
#     Name = "S3 ALB Logs for ${var.project_name}"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "diag_upload_service_alb_logs" {
#   bucket = aws_s3_bucket.diag_upload_service_alb_logs.bucket

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "aws:kms"
#     }
#   }
# }
