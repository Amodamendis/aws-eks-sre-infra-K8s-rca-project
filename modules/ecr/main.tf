resource "aws_ecr_repository" "repos" {
  for_each             = toset(var.repositories)
  name                 = each.value
  image_tag_mutability = "MUTABLE"
  force_delete         = true # Allows you to destroy cleanly later

  image_scanning_configuration {
    scan_on_push = true
  }
}