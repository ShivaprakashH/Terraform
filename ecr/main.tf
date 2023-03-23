resource "aws_ecr_repository" "demo-repository" {
  name                 = "demo-repo"
  image_tag_mutability = "IMMUTABLE"
}