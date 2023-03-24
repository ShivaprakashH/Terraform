variable "counts" {
  type = number
  default = 2
}

variable "subId" {
  type = list(string)
}

resource "aws_eip" "gateway" {
  count      = var.counts
  vpc        = true
}

resource "aws_nat_gateway" "gateway" {
  count         = var.counts
  subnet_id     = element(var.subId, count.index)
  allocation_id = element(aws_eip.gateway.*.id, count.index)
}

output "natGateId" {
  value = aws_nat_gateway.gateway.*.id
}