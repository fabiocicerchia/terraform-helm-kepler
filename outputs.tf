output "namespace" {
  description = "Kubernetes namespace where Kepler is deployed"
  value       = helm_release.kepler_operator.namespace
}

output "release_name" {
  description = "Helm release name of Kepler Operator"
  value       = helm_release.kepler_operator.name
}

output "chart_version" {
  description = "Chart version of Kepler deployment"
  value       = helm_release.kepler_operator.version
}
