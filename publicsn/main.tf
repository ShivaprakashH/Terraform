resource "aws_subnet" "public" {
  count                   = var.counts
  cidr_block              = cidrsubnet(var.cidrBlock, 8, 2 + count.index)
  availability_zone       = var.availabilityZone[count.index]
  vpc_id                  = var.vpcId
  map_public_ip_on_launch = true
}

output "subnetId" {
  value = aws_subnet.public.*.id
}