@domain:deployment-outputs @area:release-details @from:terraform-helm-kepler/outputs
Feature: Reporting the deployed Kepler release
  Gives the operator's calling Terraform configuration the namespace, release name and chart version Kepler actually landed with, so downstream resources and dashboards can refer to it without hard-coding.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration
    And the Kepler Operator Helm release has been applied

  @id:deployment-outputs.release-details.001 @rule:kepler.outputs.reports-namespace-and-release-name @inferred @source:outputs.tf#namespace
  Scenario Outline: The module reports the namespace and release name Kepler was deployed with
    Given the operator set the namespace to "<namespace input>" and the release name to "<release name input>"
    When the operator reads the module outputs
    Then the "namespace" output is "<namespace output>"
    And the "release_name" output is "<release name output>"

    Examples:
      | namespace input | release name input | namespace output | release name output |
      | (not set)       | (not set)          | kepler-operator  | kepler-operator     |
      | monitoring      | kepler             | monitoring       | kepler              |

  @id:deployment-outputs.release-details.002 @rule:kepler.outputs.reports-pinned-chart-version @inferred @source:outputs.tf#chart_version
  Scenario: A pinned chart version is reported back as the deployed version
    Given the operator pinned the chart version to "0.21.1"
    When the operator reads the module outputs
    Then the "chart_version" output is "0.21.1"

  @id:deployment-outputs.release-details.003 @rule:kepler.outputs.reports-resolved-latest-chart-version @inferred @source:outputs.tf#chart_version
  Scenario: When no chart version is pinned, the module reports the version Helm actually installed
    Given the operator left the chart version empty
    And the latest Kepler Operator chart in the registry is "0.21.1"
    When the operator reads the module outputs
    Then the "chart_version" output is "0.21.1"
