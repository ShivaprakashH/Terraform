resource "aws_appautoscaling_target" "dev_to_target" {
  max_capacity = var.maxInstanceCapacity
  min_capacity = var.minInstanceCapacity
  resource_id = var.resourceId
  scalable_dimension = var.scalableDimension
  service_namespace = var.serviceNamespace
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name = var.autoScalePname
  policy_type = var.autoScalePtype
  resource_id = aws_appautoscaling_target.dev_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dev_to_target.scalable_dimension
  service_namespace = aws_appautoscaling_target.dev_to_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefinedMetricType
    }
    target_value = var.targetValue
  }
}