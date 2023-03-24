variable "subId" {
    type = list(string)
}

variable "vpcId" {
    type = string
}

variable "counts" {
  type = number
  default = 2
}

variable "cidrBlock" {
  type = string
}

variable "natGatewayId" {
  type = list(string)
}

resource "aws_route_table" "private" {
  count  = var.counts
  vpc_id = var.vpcId
  route {
    cidr_block = var.cidrBlock
    nat_gateway_id = element(var.natGatewayId, count.index)
  }
}

resource "aws_route_table_association" "private" {
  count          = var.counts
  subnet_id      = element(var.subId, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}