variable "cidrBlocks" {
  type = string
  default = "10.0.0.0/16"
}

resource "aws_vpc" "default" {
  cidr_block = var.cidrBlocks
}

output "cidrBlock" {
  value = aws_vpc.default.cidr_block
}

output "vpcId" {
  value = aws_vpc.default.id
}

output "routeTableId" {
  value = aws_vpc.default.main_route_table_id
}