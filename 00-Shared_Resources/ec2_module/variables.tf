
# █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀ 
# ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█ 

variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ec2_key_name" {
  description = "Name of the EC2 Key Pair to assign to instance"
  type        = string
  default     = null
}

variable "ssm_session_support" {
  description = "Whether to enable support for the SSM Session Manager"
  type        = bool
}

variable "vpc_id" {
  description = "ID of the VPC in which to launch the instance"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet in which to launch the instance"
}

variable "auto_assign_ipv4" {
  description = "Whether to auto-assign a public IPv4 address to the instance"
  type        = bool
}

