resource "aws_security_group" "lb" {
  name        = var.securityGroupName
  vpc_id      = var.vpcId

  ingress {
    protocol    = "tcp"
    from_port   = var.httpPort
    to_port     = var.httpPort
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "default" {
  name            = var.loadBalancerName
  subnets         = var.subId
  security_groups = [aws_security_group.lb.id]
}

resource "aws_lb_target_group" "hello_world" {
  name        = var.lbTargetGrpName
  port        = var.httpPort
  protocol    = var.protocol
  vpc_id      = var.vpcId
  target_type = "ip"
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.hello_world.id
    type             = "forward"
  }
}

output "awsDnsName" {
  value = aws_lb.default.dns_name
}

output "lbSecurityGrpId" {
  value = aws_security_group.lb.id
}

output "lbTargetGrpId" {
  value = aws_lb_target_group.hello_world.id
}
