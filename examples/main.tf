terraform {
  required_version = ">= 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

module "kepler" {
  source = "../"

  release_name  = "kepler"
  namespace     = "kepler-system"
  chart_version = ""

  values = yamlencode({})
}
