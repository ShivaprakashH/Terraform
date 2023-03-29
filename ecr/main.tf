terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

/* resource "aws_ecr_repository" "demo-repository" {
  name                 = "demo-repo"
  image_tag_mutability = "IMMUTABLE"
}

output "ecrRepoDetails" {
  value = aws_ecr_repository.demo-repository
} */


/* 
Below is the example out put 
ecrRepoDetails = {
  "arn" = "arn:aws:ecr:us-east-2:555769791824:repository/demo-repo"
  "encryption_configuration" = tolist([
    {
      "encryption_type" = "AES256"
      "kms_key" = ""
    },
  ])
  "force_delete" = tobool(null)
  "id" = "demo-repo"
  "image_scanning_configuration" = tolist([
    {
      "scan_on_push" = false
    },
  ])
  "image_tag_mutability" = "IMMUTABLE"
  "name" = "demo-repo"
  "registry_id" = "555769791824"
  "repository_url" = "555769791824.dkr.ecr.us-east-2.amazonaws.com/demo-repo"
  "tags" = tomap(null) // of string 
  "tags_all" = tomap({
    "Name" = "architect-demo"
  })
  "timeouts" = null // object 
} */