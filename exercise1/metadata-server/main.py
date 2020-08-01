import boto3
import json
from flask import Flask
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class HealthCheck(Resource):
    def get(self):
        return {'message': 'This is only for healthcheck purposes'}

class GetMetadata(Resource):
    def get(self):
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
            output["instances"][instance.id]["public_ip"] = instance.public_ip_address

        return output

class GetInstances(Resource):
    def get(self, instance_name):
        return {'message': 'This is a placeholder'}

api.add_resource(HealthCheck, '/')
api.add_resource(GetInstances, '/instance/<string:instance_name>')
api.add_resource(GetMetadata, '/metadata')

if __name__ == "__main__":
    app.run(debug=True)