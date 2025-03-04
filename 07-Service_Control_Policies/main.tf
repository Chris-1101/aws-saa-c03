
# ▀█▀ █▀▀ █▀█ █▀█ ▄▀█ █▀▀ █▀█ █▀█ █▀▄▀█ 
# ░█░ ██▄ █▀▄ █▀▄ █▀█ █▀░ █▄█ █▀▄ █░▀░█ 

# NOTE: Using local state for now

# General Account
provider "aws" {
  region  = "us-east-1"
  profile = "saa-gen-admin"
}

# Production Account
provider "aws" {
  alias   = "prod"
  region  = "us-east-1"
  profile = "saa-prod-admin"
}

