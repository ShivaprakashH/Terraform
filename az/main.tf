data "aws_availability_zones" "available_zones" {
  state = "available"
}

output "name" {
  value = data.aws_availability_zones.available_zones.names
}