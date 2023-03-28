provider "aws" {
  region = "us-east-2"
  profile = "produser"
  default_tags {
    tags = {
      Name = "architect-demo"
    }
  }
}