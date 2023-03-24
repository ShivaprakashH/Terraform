variable "routeTableId" {
    type = string
}

variable "internetGatewayId" {
    type = string
}

resource "aws_route" "internet_access" {
  route_table_id         = var.routeTableId
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internetGatewayId
}