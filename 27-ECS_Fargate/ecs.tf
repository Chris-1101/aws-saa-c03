
# █▀▀ █░░ ▄▀█ █▀ ▀█▀ █ █▀▀   █▀▀ █▀█ █▄░█ ▀█▀ ▄▀█ █ █▄░█ █▀▀ █▀█   █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ 
# ██▄ █▄▄ █▀█ ▄█ ░█░ █ █▄▄   █▄▄ █▄█ █░▀█ ░█░ █▀█ █ █░▀█ ██▄ █▀▄   ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ 

# ECS Cluster
resource "aws_ecs_cluster" "saa_cats" {
  name = local.cluster_name

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.ecs_default.arn
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "cats" {
  family = local.task_name

  requires_compatibilities = [ "FARGATE" ]
  execution_role_arn       = aws_iam_role.ecs_exec.arn
  container_definitions    = templatefile("json/cats_container.json", {
    task_name = local.task_name
  })

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }

  network_mode = "awsvpc"
  cpu          = 512
  memory       = 1024
}

