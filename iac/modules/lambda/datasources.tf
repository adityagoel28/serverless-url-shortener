data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_file_path
  output_path = "${var.name}_lambda_function_payload.zip"
}

# data "template_file" "assume_role" {
#   template = file("${path.module}/templates/lambda_assume_role_policy.json")
# }

# data "template_file" "policies" {
#   template = file("${path.module}/templates/lambda_policy.json")
# }

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "policies" {
  override_policy_documents = var.policies

  statement {
    effect = "Allow"
    sid    = "LogToCloudwatch"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

