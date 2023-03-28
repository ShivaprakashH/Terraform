variable "ecsClusterName" {
  type = string
  default = "example-cluster"
}

variable "ecsServiceName" {
  type = string
  default= "hello-world-service"
}

variable "ecsFamilyName" {
  type = string
  default= "hello-world-app"
}

variable "ecsCapability" {
  type = string
}

variable "iamRoleArns" {
  type = string
}

variable "escTaskSecGrpName" {
  type = string
}

variable "vpcId" {
    type = string
}

variable "httpPort" {
    type = number
    default = 8081
}

variable "subId" {
  type = list(string)
}

variable "lbTargetGroups" {
  type = string
}

variable "ecsLbContainerName" {
  type = string
}

variable "lbSecGroups" {
  type = string
}

variable "cidrBlock" {
  type = string
}