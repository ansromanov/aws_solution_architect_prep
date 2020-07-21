#!/bin/bash
yum update -y
yum install httpd python-pip git -y
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo "<html><h1>Hello, world! Instance ID: ${instance_id}</h1></html>" > /var/www/html/index.html
service httpd start
chkconfig httpd on