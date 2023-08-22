data "aws_nat_gateway" "nat" {
  id = "nat-0d688bbff8a47b274"
}

data "aws_vpc" "vpc" {
  id = "vpc-00bf0d10a6a41600c"
}

data "aws_iam_role" "lambda" {
  name = "DevOps-Candidate-Lambda-Role"
}

## creating a zip of fuction file 

data "archive_file" "lambda_function" {
  type        = "zip"
  output_path = "./lambda_function.zip"
  source_dir = "./lambda_function.py"

}