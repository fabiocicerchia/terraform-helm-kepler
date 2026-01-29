resource "helm_release" "kepler_operator" {
  name       = var.release_name
  repository = "oci://quay.io/sustainable_computing_io/charts/kepler-operator"
  chart      = ""
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}
