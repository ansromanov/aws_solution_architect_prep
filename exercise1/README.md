# Exercise 1. Get private ip addresses for group of instances using metadata server

1. Create network infrastructure

    ```sh
    cd tf-vpc
    terraform plan
    terraform apply
    ```

    This will create VPC, private and public subnets.

1. Create application

    ```sh
    cd tf-app
    terraform plan
    terraform apply
    ```

    This will created a set of private instances and public instance that run metadata serve.
    After creating infrastructure, you could see public instance DNS and IP address:

    ```sh
    Apply complete! Resources: 19 added, 0 changed, 0 destroyed.
    ...
    public_instance_dns = ec2-13-53-36-185.eu-north-1.compute.amazonaws.com
    public_instance_ip = 13.53.36.185
    ```

1. Check that metadata server up and running

    ```sh
    curl ec2-13-53-36-185.eu-north-1.compute.amazonaws.com:5000
    {"message": "This is only for healthcheck purposes"}
    ```

1. Get private instances metadata

    ```sh
    curl ec2-13-53-36-185.eu-north-1.compute.amazonaws.com:5000/metadata | jq .
    ```
