# Exercise 2. Get private ip addresses for group of instances using API Gateway + Lambda

1. Create network infrastructure

    ```sh
    cd tf-vpc
    terraform plan
    terraform apply
    ```

    This will create VPC, private and public subnets.

    ```sh
    Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

    Outputs:
    vpc_id = vpc-0286d30b5555c6c74
    ```

1. Create application

    ```sh
    cd tf-app
    terraform plan
    terraform apply
    ```

    This will create a set of private instances.
    After creating infrastructure, you could see IP addresses for private instances:

    ```sh
    Apply complete! Resources: 12 added, 0 changed, 0 destroyed.

    Outputs:
    private_instance_ip = [
    "10.1.0.15",
    "10.1.0.51",
    "10.1.0.4",
    ]
    ```

1. Create metadata REST API

    ```sh
    cd tf-api
    terraform plan
    terraform apply
    ```

    This will create a Lambda function and API Gateway.
    After creating infrastructure, you could see public instance DNS and IP address:

    ```sh
    Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

    Outputs:
    get_instances_url = https://npgzno9b99.execute-api.eu-north-1.amazonaws.com/test/instances
    rest_api_id = npgzno9b99
    ```

1. Get private instances metadata

    ```sh
    curl -X GET "https://npgzno9b99.execute-api.eu-north-1.amazonaws.com/test/instances" | jq .
    ```

1. Don't forget to destroy your infrastructure

    ```sh
    cd tf-api
    terraform destroy

    cd tf-app
    terraform destroy

    cd tf-vpc
    terraform destroy
    ```
