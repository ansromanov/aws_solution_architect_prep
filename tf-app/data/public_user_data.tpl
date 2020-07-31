#!/bin/bash
yum update -y
yum install httpd python-pip git -y
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<html><h1>Hello, world! Instance ID: ${instance_id}</h1></html>" > /var/www/html/index.html
service httpd start
chkconfig httpd on

git clone https://github.com/ansromanov/aws_solution_architect_prep.git
sudo pip install -r aws_solution_architect_prep/python/requirements.txt

export FLASK_APP=aws_solution_architect_prep/python/ec2/main.py
export AWS_DEFAULT_REGION=eu-north-1
flask run --host=0.0.0.0