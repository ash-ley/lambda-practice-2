resource "aws_s3_bucket" "lambda_practice_2" {
  bucket = "ta-ar-lambda-practice-2"

  tags = {
    Name = "Lambda practice 2"
  }
}

resource "aws_dynamodb_table" "lambda_table" {
  name = "metadata"
  hash_key = "fileName"

  attribute {
    name = "fileName"
    type = "S"
  }

  tags = {
    Name = "Metadata for s3"
  }
}