
# █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀ 
# ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█ 

variable "vpc_name" {
  description = "Name of the VPC to create"
  type        = string
}

variable "public" {
  description = "Whether to Include Internet Gateway"
  type        = bool
  default     = true
}

