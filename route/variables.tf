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

variable "routeTableId" {
    type = string
}

variable "internetGatewayId" {
    type = string
}