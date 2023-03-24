variable "vpcId" {
  type = string
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = var.vpcId
}

output "igId" {
  value = aws_internet_gateway.gateway.id
}