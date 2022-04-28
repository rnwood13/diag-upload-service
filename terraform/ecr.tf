resource "aws_ecr_repository" "diag_upload_service" {
  name                 = "diag_upload_service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
