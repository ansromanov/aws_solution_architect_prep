import boto3
import json

ec2 = boto3.resource('ec2')

ec2_tag = "Service"


instances = ec2.instances.filter(
    Filters=[
        {
            'Name': 'tag:Service',
            'Values': [
                'application'
            ]
        },
        {
            'Name': 'instance-state-name',
            'Values': [
                'running'
            ]
        }
    ]
)

output = {
    "instances": {}
}

for instance in instances:
    output["instances"][instance.id] = {}
    for tag in instance.tags:
        if tag['Key'] == 'Name':
            output["instances"][instance.id]["name"] = tag['Value']
    output["instances"][instance.id]["private_ip"] = instance.private_ip_address

json_output = (json.dumps(output, indent=2))
print(json_output)