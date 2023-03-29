
resource "aws_ecs_task_definition" "hello_world" {
  family                   = var.ecsFamilyName
  network_mode             = "awsvpc"
  requires_compatibilities = [var.ecsCapability]
  cpu                      = 1024
  memory                   = 2048
  task_role_arn = var.iamRoleArns
  execution_role_arn = var.iamRoleArns
  container_definitions = jsonencode([
    {
      name      = "hello-world-app"
      image     = "docker.io/shivaprakashhurukadli/demo-repo:latest"
      cpu       = 1024
      memory    = 2048
      networkMode = "awsvpc"
      portMappings = [
        {
          containerPort = 8081
          hostPort = 8081
          protocol = "tcp"
        }
      ]
    }
  ])
}

resource "aws_security_group" "hello_world_task" {
  name        = var.escTaskSecGrpName
  vpc_id      = var.vpcId

  ingress {
    protocol        = "tcp"
    from_port       = var.httpPort
    to_port         = var.httpPort
    security_groups = [var.lbSecGroups]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.cidrBlock]
  }
}

resource "aws_ecs_cluster" "main" {
  name = var.ecsClusterName
}

resource "aws_ecs_service" "hello_world" {
  name            = var.ecsServiceName
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.hello_world.arn
  launch_type     = var.ecsCapability

  network_configuration {
    security_groups = [aws_security_group.hello_world_task.id]
    subnets = var.subId 
  }

  load_balancer {
    target_group_arn = var.lbTargetGroups
    container_name   = var.ecsLbContainerName
    container_port   = var.httpPort
  }
}

output "clusterName" {
  value = aws_ecs_cluster.main.name
}

output "serviceName" {
  value = aws_ecs_service.hello_world.name
}