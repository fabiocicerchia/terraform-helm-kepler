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

resource "null_resource" "deploy_powermonitor" {
  depends_on = [helm_release.kepler_operator]
  count      = var.deploy_powermonitor ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/sustainable-computing-io/kepler-operator/v1alpha1/config/samples/kepler.system_v1alpha1_powermonitor.yaml"
  }
}
