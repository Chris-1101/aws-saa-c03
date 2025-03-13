
# █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀ 
# ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█ 

variable "ec2_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "Type and size of the instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "AMI to use to launch the EC2 instance"
  type        = string
  default     = "latest"
}

variable "ec2_user_data" {
  description = "EC2 user-data script"
  type        = string
  default     = null
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

