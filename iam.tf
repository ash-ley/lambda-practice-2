resource "aws_iam_role" "lambda_role" {
  name = "lambda_practice_2"

  assume_role_policy = <<EOF
{
      "Version" : "2012-10-17",
      "Statement" : [
          {
            "Action" : [
                "sts:AssumeRole"
            ],
            "Principal" : {
                "Service" : "lambda.amazonaws.com"
            },
            "Effect" : "Allow",
            "Sid" : "LambdaRole2"
          }
      ]
}
EOF
}

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
                "s3:List*",
                "s3:PutObject"
            ],
            "Effect" : "Allow",
            "Sid" : "S3ObjectActionsForLambda",
            "Resource" : ["arn:aws:s3:::*"]
            },
            {
              "Action" : [
                "dynamodb:PutItem"
              ],
              "Effect" : "Allow",
              "Sid" : "LambdaDynamoDB"
              "Resource" : ["${aws_dynamodb_table.lambda_table.arn}"]
            }
      ]
  }
EOF
depends_on = [
  aws_dynamodb_table.lambda_table
]
}

resource "aws_iam_role_policy_attachment" "policy_for_lambda" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.my_policy.arn
}