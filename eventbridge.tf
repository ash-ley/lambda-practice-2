resource "aws_cloudwatch_event_rule" "s3-uploads" {
  name        = "capture-s3-uploads"
  description = "Capture each upload to my S3 bucket"

  event_pattern = <<EOF
{
	"source": ["aws.s3"],
	"account": ["${var.accountID}"],
	"detail": {
		"eventSource": ["s3.amazonaws.com"],
		"eventName": ["PutObject"],
		"requestParameters": {
			"bucketName": ["ta-ar-lambda-practice-2"],
			"key": [{
				"prefix": "*"
			}]
		}
	}
}
EOF
}