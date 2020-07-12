variable "cluster_name" {
  description = "Name for all cluster resources"
  type        = string
  default     = "training"
}

variable "ami" {
  description = "Default AMI for cluster nodes"
  type        = string
  default     = "ami-04697c9bb5d6135a2"
}

variable "region" {
  description = "Define region in AWS"
  type        = string
  default     = "eu-north-1"
}

variable "ssh_key" {
  description = "Public SSH key name"
  type        = string
  default     = "dbtsolarch"
}

variable "custom_tags" {
  description = "Custom tags to set on ASG instances"
  type        = map(string)
  default     = {}
}

variable "alb_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}
