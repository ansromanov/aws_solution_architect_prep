import json
import boto3


def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')
    
    if 'service' in event:
        service = event['service']
    else:
        service = 'application'
    
    filters = [
            {
                'Name': 'tag:Service',
                'Values': [service]
            },
            {
                'Name': 'instance-state-name',
                'Values': [
                    'running'
                ]
            }
        ]
    
    instances = ec2.instances.filter(Filters=filters)
    
    output = {}
    
    for instance in instances:
        output[instance.id] = {}
        for tag in instance.tags:
            if tag['Key'] == 'Name':
                output[instance.id]["name"] = tag['Value']
        output[instance.id]["private_ip"] = instance.private_ip_address
    
    print(output)

    return {
        'statusCode': 200,
        'body': json.dumps(output)
    }
