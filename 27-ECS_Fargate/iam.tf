
# █ █▀▄ █▀▀ █▄░█ ▀█▀ █ ▀█▀ █▄█   ▄▀█ █▀▀ █▀▀ █▀▀ █▀ █▀   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ 
# █ █▄▀ ██▄ █░▀█ ░█░ █ ░█░ ░█░   █▀█ █▄▄ █▄▄ ██▄ ▄█ ▄█   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░ 

# ECS Task Execution Role
resource "aws_iam_role" "ecs_exec" {
  name               = "ECSTaskExecutionRole"
  path               = "/"
  assume_role_policy = file("json/trust-policy.json")
}

# Attach SSM Managed Instance Core policy to instance role
resource "aws_iam_role_policy_attachment" "ecs_exec" {
  role       = aws_iam_role.ecs_exec.name
  policy_arn = data.aws_iam_policy.ecs_task_exec.arn
}

