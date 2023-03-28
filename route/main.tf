resource "aws_route" "internet_access" {
  route_table_id         = var.routeTableId
  destination_cidr_block = var.cidrBlock
  gateway_id             = var.internetGatewayId
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