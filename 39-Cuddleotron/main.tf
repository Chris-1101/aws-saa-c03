
# ▀█▀ █▀▀ █▀█ █▀█ ▄▀█ █▀▀ █▀█ █▀█ █▀▄▀█ 
# ░█░ ██▄ █▀▄ █▀▄ █▀█ █▀░ █▄█ █▀▄ █░▀░█ 

# NOTE: Using local state for now

# Cloud Provider
provider "aws" {
  alias   = "gen"
  region  = "us-east-1"
  profile = "saa-gen-terraform"
}

