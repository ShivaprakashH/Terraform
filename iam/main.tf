resource "aws_iam_role" "ECSToECR" {
  name = "ECSToECR"
  assume_role_policy = file("rolepolicy.json")
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServer" {
    for_each = toset([
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
        "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess"
    ])
    role       = aws_iam_role.ECSToECR.name
    policy_arn = each.value
    depends_on = [
      aws_iam_role.ECSToECR
    ]
}

output "iamRoleArn" {
  value = aws_iam_role.ECSToECR.arn
}
