data "archive_file" "lambda_file" {
  type        = "zip"
  source_file = "${path.module}/metadata.py"
  output_path = "${path.module}/lambda-practice2.zip"
}

resource "aws_lambda_function" "my_lambda" {
  filename      = data.archive_file.lambda_file.output_path
  function_name = "metadata"
  role          = data.aws_iam_role.lambda.arn
  handler       = "metadata.get_metadata"
  runtime       = "python3.8"
}

resource "aws_lambda_permission" "metadata_perm" {
  statement_id  = "AllowFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lambda_practice_2.arn
}

resource "aws_s3_bucket_notification" "upload_notification" {
  bucket = aws_s3_bucket.lambda_practice_2.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.my_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [
    aws_lambda_permission.metadata_perm
  ]
}