output "kepler_namespace" {
  description = "The namespace where Kepler is deployed"
  value       = module.kepler.namespace
}

output "kepler_release_name" {
  description = "The Helm release name of Kepler"
  value       = module.kepler.release_name
}

output "kepler_chart_version" {
  description = "The chart version of the deployed Kepler"
  value       = module.kepler.chart_version
}
