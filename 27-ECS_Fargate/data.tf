
# █▀▄ ▄▀█ ▀█▀ ▄▀█   █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ 
# █▄▀ █▀█ ░█░ █▀█   ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ 

data "aws_vpc" "default" {
  default = true
}

data "aws_iam_policy" "ecs_task_exec" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

