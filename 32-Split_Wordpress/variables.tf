
# █░█ ▄▀█ █▀█ █ ▄▀█ █▄▄ █░░ █▀▀ █▀ 
# ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█ 

# NOTE: create a terraform.tfvars file with these defined
#  to avoid being prompted at every plan or apply

variable "db_name" {
  description = "Name of the wordpress database"
  type        = string
}

variable "db_user" {
  description = "Name of the wordpress admin user"
  type        = string
}

variable "db_pass" {
  description = "Password for the wordpress admin user"
  type        = string
  sensitive   = true
}

variable "db_root_pass" {
  description = "Password for the mysql root user"
  type        = string
  sensitive   = true
}

