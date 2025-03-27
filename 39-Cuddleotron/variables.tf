
# █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀ 
# ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█ 

# NOTE: create a terraform.tfvars file with these defined
#  to avoid being prompted at every plan or apply

variable "sender_email" {
  description = "SES sender email address"
  type        = string
}

variable "receiver_email" {
  description = "SES receiver email address"
  type        = string
}

