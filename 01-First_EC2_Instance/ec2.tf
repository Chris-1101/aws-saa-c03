
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# SSH Public Key
resource "aws_key_pair" "operations" {
  key_name   = "operations"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+WS6S5eQWTHWfMeOrtoYNjOqvuN0zvOy24ZtTjNlK9 operations-2025-02-25"
}


