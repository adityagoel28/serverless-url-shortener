module "create_short_url_lambda" {
  source           = "./modules/lambda"
  name             = "create-short-url"
  source_file_path = "./init_code/index.py"
  policies = [
    data.aws_iam_policy_document.put_url_item.json
  ]

  environment_variables = {
    BASE_URL = "https://qor5ds5psa.execute-api.ap-south-1.amazonaws.com/live", # fetch this value from api gateway invoke url only
  }
}

module "redirect_lambda" {
  source           = "./modules/lambda"
  name             = "redirect"
  source_file_path = "./init_code/index.py"
  policies = [
    data.aws_iam_policy_document.allow_get_url_lambda.json
  ]
}