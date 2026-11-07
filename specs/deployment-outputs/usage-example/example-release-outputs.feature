@domain:deployment-outputs @area:usage-example @from:examples/outputs
Feature: Seeing the deployed Kepler release from the usage example
  Gives an operator who applies the ready-made example configuration the namespace, release name and chart version of the Kepler deployment, so they can find and check it without opening the module.

  Background:
    Given the operator applies the usage example configuration, which deploys Kepler as release "kepler" in namespace "kepler-system" with no chart version pinned

  @id:deployment-outputs.usage-example.003 @rule:deployment-outputs.usage-example.surfaces-release-details @inferred @source:examples/outputs.tf#kepler_namespace
  Scenario Outline: The usage example reports where and which Kepler release it deployed
    Given the Kepler deployment from the usage example has been applied
    When the operator reads the example's output "<output>"
    Then the output "<output>" shows <value>
    And the output description reads "<description>"

    Examples:
      | output               | value                                                                                | description                              |
      | kepler_namespace     | "kepler-system"                                                                      | The namespace where Kepler is deployed   |
      | kepler_release_name  | "kepler"                                                                             | The Helm release name of Kepler          |
      | kepler_chart_version | the chart version actually installed (the latest available, because none was pinned) | The chart version of the deployed Kepler |
