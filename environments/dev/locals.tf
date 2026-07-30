locals {
  common_tags = {
    "Project"     = "Jenkins-cluster"
    "Environment" = var.env
  }
}