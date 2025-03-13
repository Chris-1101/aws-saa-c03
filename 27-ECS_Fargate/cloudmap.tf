
# █▀▀ █░░ █▀█ █░█ █▀▄ █▀▄▀█ ▄▀█ █▀█ 
# █▄▄ █▄▄ █▄█ █▄█ █▄▀ █░▀░█ █▀█ █▀▀ 

resource "aws_service_discovery_http_namespace" "ecs_default" {
  name = local.cluster_name

  tags = {
    AmazonECSManaged = true
  }
}

