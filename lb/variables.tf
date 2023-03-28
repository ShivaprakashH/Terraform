variable "vpcId" {
    type = string
}

variable "securityGroupName" {
  type = string
}

variable "loadBalancerName" {
  type = string
}

variable "lbTargetGrpName" {
  type = string
}

variable "protocol" {
  type = string
}

variable "httpPort" {
  type = number
  default = 80
}

variable "subId" {
  type = list(string)
}