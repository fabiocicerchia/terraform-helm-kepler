# Kepler Environmental Impact Module

Terraform module to deploy Kepler (Kubernetes Environmental Power Profiling Operator) on Kubernetes using Helm.

## Overview

Kepler tracks environmental impact and power consumption of your Kubernetes cluster. It provides metrics for energy efficiency and sustainability monitoring.

- **Power Profiling**: Track power consumption at container and node levels
- **Environmental Metrics**: Monitor carbon emissions and energy usage
- **Operator Pattern**: Uses Kepler Operator for deployment
- **PowerMonitor Resources**: Optional PowerMonitor for detailed power metrics
- **Cert Manager Integration**: Automatically deploys cert-manager as a dependency

## Quick Start

```hcl
module "kepler" {
  source = "git::https://github.com/fabiocicerchia/terraform-helm-kepler.git?ref=main"

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
| `deploy_powermonitor` | Deploy the Kepler PowerMonitor resource | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| `namespace` | Kubernetes namespace where Kepler is deployed |
| `release_name` | Helm release name of Kepler Operator |
| `chart_version` | Chart version of Kepler deployment |

## Requirements

- Terraform >= 1.0
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

## Dependencies

This module automatically deploys:
- Cert Manager v1.18.2 (required for Kepler Operator)
- PowerMonitor resource (optional, controllable via `deploy_powermonitor`)

## Usage

### Basic Deployment

```hcl
module "kepler" {
  source = "git::https://github.com/fabiocicerchia/terraform-helm-kepler.git?ref=main"
}
```

### Without PowerMonitor

```hcl
module "kepler" {
  source = "git::https://github.com/fabiocicerchia/terraform-helm-kepler.git?ref=main"

  deploy_powermonitor = false
}
```

### Pin Chart Version

```hcl
module "kepler" {
  source = "git::https://github.com/fabiocicerchia/terraform-helm-kepler.git?ref=main"

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
