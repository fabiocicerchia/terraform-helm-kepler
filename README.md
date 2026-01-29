# Terraform Module for Kepler

Terraform module to deploy Kepler (Kubernetes Environmental Power Profiling Operator) on Kubernetes using Helm.

## Why This Matters

Understanding the energy footprint of your workloads is essential for meaningful sustainability improvements. Without accurate power consumption data at the container and pod level, efforts to reduce environmental impact are based on assumptions rather than facts.

Kepler (Kubernetes-based Efficient Power Level Exporter) provides:

* 🔌 **Container-level power metrics** showing actual energy consumption
* 📊 **Real-time monitoring** of power usage across your entire cluster
* 🎯 **Workload comparison** to identify energy-inefficient applications
* 💡 **Actionable insights** for reducing energy waste
* 📈 **Carbon estimation** based on actual power consumption

By making power consumption visible at the workload level, Kepler enables teams to identify inefficiencies, optimise resource allocation, and make data-driven decisions about sustainability—transforming energy efficiency from guesswork into measurable engineering practice.

## Overview

Kepler tracks environmental impact and power consumption of your Kubernetes cluster. It provides metrics for energy efficiency and sustainability monitoring.

- **Power Profiling**: Track power consumption at container and node levels
- **Environmental Metrics**: Monitor carbon emissions and energy usage
- **Operator Pattern**: Uses Kepler Operator for deployment
- **PowerMonitor Resources**: Optional PowerMonitor for detailed power metrics
- **Cert Manager Integration**: Automatically deploys cert-manager as a dependency

## Dependencies

**Important:** Kepler requires both Prometheus and cert-manager to function properly:

1. **Prometheus**: Kepler exports metrics to Prometheus for monitoring. Ensure you have Prometheus deployed in your cluster.
2. **cert-manager**: Kepler requires [cert-manager](https://cert-manager.io/) to be installed before deployment. Without cert-manager, Kepler will not function properly. Install it using:
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml
```

## Quick Start

```hcl
module "kepler" {
  source = "fabiocicerchia/kepler/helm"

  release_name    = "kepler-operator"
  namespace       = "kepler-operator"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `release_name` | Helm release name for Kepler Operator | `string` | `"kepler-operator"` | no |
| `namespace` | Kubernetes namespace for Kepler Operator | `string` | `"kepler-operator"` | no |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""` | no |
| `values` | Helm values for Kepler Operator deployment | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `namespace` | Kubernetes namespace where Kepler is deployed |
| `release_name` | Helm release name of Kepler Operator |
| `chart_version` | Chart version of Kepler deployment |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

## Dependencies

This module automatically deploys:
- Cert Manager v1.18.2 (required for Kepler Operator)

## Usage

### Basic Deployment

```hcl
module "kepler" {
  source = "fabiocicerchia/kepler/helm"
}
```

### Without PowerMonitor

```hcl
module "kepler" {
  source = "fabiocicerchia/kepler/helm"
}
```

### Pin Chart Version

```hcl
module "kepler" {
  source = "fabiocicerchia/kepler/helm"

  chart_version   = "1.0.0"
}
```

## Verify Deployment

```bash
# Check Kepler pod
kubectl get pods -n kepler-operator

# Check PowerMonitor (if enabled)
kubectl get powermonitors -A

# View Kepler logs
kubectl logs -n kepler-operator -l app=kepler
```

## Resources

- [Kepler Documentation](https://sustainable-computing.io/kepler/)
- [Kepler Operator GitHub](https://github.com/sustainable-computing-io/kepler-operator)
- [Kepler Helm Chart](https://github.com/sustainable-computing-io/kepler)

## License

MIT
