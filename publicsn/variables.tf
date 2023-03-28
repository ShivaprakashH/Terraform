variable "vpcId" {
  type = string
}

variable "cidrBlock" {
  type = string
}

variable "counts" {
  type = number
  default = 2
}

variable "availabilityZone" {
  type = list(string)
}