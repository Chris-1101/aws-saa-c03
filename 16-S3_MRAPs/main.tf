
# ▀█▀ █▀▀ █▀█ █▀█ ▄▀█ █▀▀ █▀█ █▀█ █▀▄▀█ 
# ░█░ ██▄ █▀▄ █▀▄ █▀█ █▀░ █▄█ █▀▄ █░▀░█ 

# NOTE: Using local state for now

# North Virginia
provider "aws" {
  region  = "us-east-1"
  profile = "saa-gen-terraform"
}

# North California
provider "aws" {
  alias   = "ncali"
  region  = "us-west-1"
  profile = "saa-gen-terraform"
}

