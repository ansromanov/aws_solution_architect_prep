## Description  
This module is used to create sample Application for AWS Solution Architech Associate exam

It creates:
- public ASG with httpd

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12, < 0.13 |
| aws | ~> 2.60 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.60 |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_port | The port the server will use for HTTP requests | `number` | `80` | no |
| ami | Default AMI for cluster nodes | `string` | `"ami-04697c9bb5d6135a2"` | no |
| cluster\_name | Name for all cluster resources | `string` | `"training"` | no |
| custom\_tags | Custom tags to set on ASG instances | `map(string)` | `{}` | no |
| region | Define region in AWS | `string` | `"eu-north-1"` | no |
| server\_port | The port the server will use for HTTP requests | `number` | `80` | no |
| ssh\_key | Public SSH key name | `string` | `"dbtsolarch"` | no |

## Outputs

No output.
