
# █▀▀ █░░ █▀█ █░█ █▀▄ █░█░█ ▄▀█ ▀█▀ █▀▀ █░█ 
# █▄▄ █▄▄ █▄█ █▄█ █▄▀ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▀█ 

resource "aws_cloudwatch_log_group" "state_machine" {
  name = "SAACuddleOTron-Logs"
}

