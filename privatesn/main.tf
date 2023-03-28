resource "aws_subnet" "private" {
  count                   = var.counts
  cidr_block              = cidrsubnet(var.cidrBlock, 8, count.index)
  availability_zone       = var.availabilityZone[count.index]
  vpc_id                  = var.vpcId
}

output "subnetId" {
  value = aws_subnet.private.*.id
}