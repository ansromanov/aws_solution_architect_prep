import boto3
import botostubs

s3 = boto3.resource('s3')  # type: botostubs.S3.S3
bucket = s3.Bucket('solarch-test')


for bucket in s3.buckets.all():
    print(bucket.name)

data = open('./Skype.jpeg', 'rb')
s3.Bucket('solarch-test').put_object(ACL='private',
                                     Body=data, Key='Skype.jpeg')

for obj in bucket.objects.all():
    print(obj.key)