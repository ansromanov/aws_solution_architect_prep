import boto3

# Get the service resource
sqs = boto3.resource('sqs')

# Print out each queue name, which is part of its ARN
for queue in sqs.queues.all():
    print(queue.url)
# Get the queue. This returns an SQS.Queue instance
queue = sqs.get_queue_by_name(QueueName='test')

# You can now access identifiers and attributes
print(queue.url)
print(queue.attributes.get('DelaySeconds'))
print(queue.attributes)

