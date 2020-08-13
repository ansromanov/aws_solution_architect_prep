
output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.this.id}"
}

output "get_instances_url" {
  value = "${join("", [aws_api_gateway_stage.test.invoke_url, aws_api_gateway_resource.instances.path])}"
}
