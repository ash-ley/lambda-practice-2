resource "aws_iam_policy" "my_policy" {
  name        = "policy-lambda-2"
  description = "My policy for lambda practice 2"

  policy = <<-EOF
  {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Action" : [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*",
            "Effect" : "Allow",
            "Sid" : "cloudwatchLambda"
          },
          {
            "Action" : [
                "s3:GetObject",
                "s3:GetObjectAcl"
            ],
            "Effect" : "Allow",
            "Sid" : "S3ObjectActionsForLambda",
            "Resource" : ["arn:aws:s3:::ta-ar-lambda-practice-2/*"]
            },
            {
              "Action" : [
                "dynamodb:PutItem"
              ],
              "Effect" : "Allow",
              "Sid" : "LambdaDynamoDB",
              "Resource" : ["${aws_dynamodb_table.lambda_table.arn}"]
            }
      ]
  }
EOF
  depends_on = [
    aws_dynamodb_table.lambda_table
  ]
}

data "aws_iam_role" "lambda" {
  name = "lambda_role"
}

resource "aws_iam_role_policy_attachment" "policy_for_lambda" {
  role       = data.aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.my_policy.arn
}