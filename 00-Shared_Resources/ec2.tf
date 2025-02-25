
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▀▄▀█ █▀█ █░█ ▀█▀ █▀▀   █▀▀ █░░ █▀█ █░█ █▀▄ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀░█ █▀▀ █▄█ ░█░ ██▄   █▄▄ █▄▄ █▄█ █▄█ █▄▀ 

# SSH Public Key
resource "aws_key_pair" "operations" {
  key_name   = local.ssh_key.name
  public_key = "${ local.ssh_key.type } ${ local.ssh_key.pub_key } ${ local.ssh_key.name }-${ local.ssh_key.date}"
}

