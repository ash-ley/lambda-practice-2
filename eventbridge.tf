# resource "aws_cloudwatch_event_rule" "s3-uploads" {
#   name        = "capture-s3-uploads"
#   description = "Capture each upload to my S3 bucket"

#   event_pattern = <<EOF
# {
#     "Records": [
#         {
#             "awsRegion": <awsRegion>,
#             "eventName": ["PutObject","CompleteMultipartUpload"],
#             "eventTime": <eventTime>,
#             "s3": {
#                 "bucket": {
#                     "name": "ta-ar-lambda-practice-2"
#                 },
#                 "object": {
#                     "eTag": "",
#                     "isDeleteMarker": <isDeleteMarker>,
#                     "key": <key>,
#                     "versionId": <versionId>
#                 }
#             }
#         }
#     ]
# }
# EOF
# }

# resource "aws_cloudwatch_event_target" "lambda" {
#   target_id = "metadata"
#   rule      = aws_cloudwatch_event_rule.s3-uploads.id
#   arn       = aws_lambda_function.my_lambda.arn
# }