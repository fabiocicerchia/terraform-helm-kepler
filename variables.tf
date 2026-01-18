variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for Kepler Operator"
  type        = string
  default     = "kepler-operator"
}

variable "namespace" {
  description = "Kubernetes namespace for Kepler Operator"
  type        = string
  default     = "kepler-operator"
}

variable "chart_version" {
  description = "Kepler Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for Kepler Operator deployment"
  type        = any
  default     = {}
}

variable "deploy_powermonitor" {
  description = "Deploy the Kepler PowerMonitor resource"
  type        = bool
  default     = true
}
