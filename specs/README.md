# Specifications of terraform-helm-kepler

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Configuration
The inputs a consumer sets to tailor the Kepler installation.

- **Chart values**: [Passing Helm values to the Kepler chart](configuration/chart-values/chart-values.feature) (1)
- **Release naming**: [Naming the Kepler Helm release](configuration/release-naming/release-naming.feature) (1)

## Deployment Outputs
What the module reports back after Kepler is deployed, for use by callers and examples.

- **Release details**: [Reporting the deployed Kepler release](deployment-outputs/release-details/release-details-outputs.feature) (3)
- **Usage example**: [Seeing the deployed Kepler release from the usage example](deployment-outputs/usage-example/example-release-outputs.feature) (1), [Trying Kepler with the ready-made example](deployment-outputs/usage-example/usage-example.feature) (2)

## Developer tooling
Build, validation and quality checks for maintaining the module.

- **Compatibility**: [Declaring supported Terraform, OpenTofu and Helm provider versions](developer-tooling/compatibility/supported-toolchain-versions.feature) (2)
- **Make commands**: [Running the standard make verbs](developer-tooling/make-commands/make-verbs.feature) (4)

## Kepler Deployment
Installing the Kepler energy-monitoring operator onto a Kubernetes cluster as a Helm release.

- **Chart versioning**: [Pinning the Kepler chart version](kepler-deployment/chart-versioning/chart-versioning.feature) (1)
- **Namespace placement**: [Choosing the Kepler namespace](kepler-deployment/namespace-placement/namespace-placement.feature) (1)
