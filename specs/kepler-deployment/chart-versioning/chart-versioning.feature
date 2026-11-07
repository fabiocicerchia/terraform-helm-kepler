@domain:kepler-deployment @area:chart-versioning @from:terraform-helm-kepler/variables
Feature: Pinning the Kepler chart version
  Lets an operator pin a Kepler chart version for reproducible installs, or take the latest by leaving it empty.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration

  @id:kepler-deployment.chart-versioning.001 @rule:kepler.chart.empty-version-means-latest @inferred @source:variables.tf#chart_version
  Scenario Outline: An empty or missing chart version installs the latest chart; a given one is pinned
    Given the operator sets the chart version to <chart_version>
    When the operator applies the configuration
    Then the Kepler Operator chart installed is <installed>

    Examples:
      | chart_version | installed                    |
      | nothing       | the latest published version |
      | "" (empty)    | the latest published version |
      | "0.21.0"      | version 0.21.0               |
