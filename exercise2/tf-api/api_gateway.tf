resource "aws_api_gateway_rest_api" "this" {
  name           = "MetadataOperations"
  description    = "This API is used to get metadata from EC2 instances"
  api_key_source = "HEADER"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  minimum_compression_size = "-1"
  tags                     = local.tags
}

resource "aws_api_gateway_resource" "instances" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "instances"
}

resource "aws_api_gateway_method" "get_instances" {
  rest_api_id      = aws_api_gateway_rest_api.this.id
  resource_id      = aws_api_gateway_resource.instances.id
  http_method      = "GET"
  api_key_required = false
  authorization    = "NONE"
}

resource "aws_api_gateway_integration" "getipaddresses_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.instances.id
  http_method             = aws_api_gateway_method.get_instances.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  connection_type         = "INTERNET"
  uri                     = aws_lambda_function.get_ip_addresses.invoke_arn
  content_handling        = "CONVERT_TO_TEXT"
}

resource "aws_api_gateway_method_response" "getipaddresses_lambda_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.instances.id
  http_method = aws_api_gateway_method.get_instances.http_method

  response_models = {
    "application/json" = "Empty"
  }

  status_code = "200"
}

resource "aws_api_gateway_deployment" "test" {
  depends_on = [aws_api_gateway_integration.getipaddresses_lambda]

  rest_api_id = aws_api_gateway_rest_api.this.id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "test" {
  stage_name            = "test"
  rest_api_id           = aws_api_gateway_rest_api.this.id
  deployment_id         = aws_api_gateway_deployment.test.id
  cache_cluster_enabled = "false"
  xray_tracing_enabled  = "false"
}