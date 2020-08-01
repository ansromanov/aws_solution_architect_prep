## Description  
This module is used to create sample VPC for AWS Solution Architech Associate exam

It creates:
- custom VPC
- private subnet
- public subnet
- internet gateway

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12, < 0.13 |
| aws | ~> 2.60 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.60 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deploy\_natgw | Deploy NAT gateway | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | n/a |
