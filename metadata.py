import boto3

def get_metadata(event, context):
    for records in event["Records"]:
        key = records["s3"]["object"]["key"]
        bucket = records["s3"]["bucket"]["name"]
    
    s3client = boto3.client('s3')

    metadata = s3client.head_object(Bucket=bucket, Key=key)
    print(metadata)