import boto3
import botostubs

s3 = boto3.resource('s3') # type: botostubs.S3.S3Resource
# s3.

for bucket in s3.buckets.all():
    print(bucket)

