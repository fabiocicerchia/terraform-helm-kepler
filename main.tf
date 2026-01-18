provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

resource "null_resource" "deploy_cert_manager" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml"
  }
}

resource "helm_release" "kepler_operator" {
  depends_on = [null_resource.deploy_cert_manager]

  name       = var.release_name
  repository = "oci://quay.io/sustainable_computing_io/charts/kepler-operator"
  chart      = "kepler-operator"
  version    = var.chart_version != "" ? var.chart_version : null

  create_namespace = true
  namespace        = var.namespace
  replace          = true

  values = [var.values]
}

resource "null_resource" "deploy_powermonitor" {
  depends_on = [helm_release.kepler_operator]
  count      = var.deploy_powermonitor ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/sustainable-computing-io/kepler-operator/v1alpha1/config/samples/kepler.system_v1alpha1_powermonitor.yaml"
  }
}
