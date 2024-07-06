data "aws_iam_policy_document" "put_url_item" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
    ]

    resources = [
      aws_dynamodb_table.urls.arn
    ]
  }
}

data "aws_iam_policy_document" "allow_get_url_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query"
    ]

    resources = [
      aws_dynamodb_table.urls.arn
    ]
  }
}