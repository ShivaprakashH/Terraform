variable "maxInstanceCapacity" {
  type = number
}

variable "minInstanceCapacity" {
  type = number
}

variable "targetValue" {
  type = number
}

variable "resourceId" {  
  type = string
}

variable "scalableDimension" {
  type = string
}

variable "serviceNamespace" {
  type = string
}

variable "autoScalePname" {
  type = string
}

variable "autoScalePtype" {
  type = string
}

variable "predefinedMetricType" {
  type = string
}