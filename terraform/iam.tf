resource "aws_iam_role" "diag_upload_service" {
  name               = "diag_upload_service-ecs-role"
  assume_role_policy = data.aws_iam_policy_document.diag_upload_service.json
}

data "aws_iam_policy_document" "diag_upload_service" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "diag_upload_service" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "diag_upload_service" {
  role       = aws_iam_role.diag_upload_service.name
  policy_arn = data.aws_iam_policy.diag_upload_service.arn
}
