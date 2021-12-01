data "archive_file" "lambda_file" {
  type = "zip"
  source_file = "${path.module}/metadata.py"
  output_path = "${path.module}/lambda-practice2.zip"
}

resource "aws_lambda_function" "my_lambda" {
  filename = data.archive_file.lambda_file.output_path
  function_name = "metadata"
  role = aws_iam_role.lambda_role.arn
  handler = "metadata.lambda_handler"
  runtime = "python3.8"
}