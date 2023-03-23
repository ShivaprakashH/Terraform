variable "app_count" {
  type = number
  default = 1
}

variable "ecs_cluster" {
  type = string
  default = "example-cluster"
}

variable "ecs_service" {
  type = string
  default= "hello-world-service"
}