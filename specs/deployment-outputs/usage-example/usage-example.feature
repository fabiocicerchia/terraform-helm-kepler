@domain:deployment-outputs @area:usage-example @from:examples/examples
Feature: Trying Kepler with the ready-made example
  Gives an operator a copy-and-apply root configuration that deploys Kepler through the module and prints where and what was deployed, so they can evaluate it before writing their own.

  Background:
    Given the operator has a Kubernetes cluster reachable by the Helm provider
    And the operator applies the example configuration shipped with the module

  @id:deployment-outputs.usage-example.001 @rule:kepler.usage-example.surfaces-release-details @inferred @source:examples/outputs.tf#kepler_namespace
  Scenario: The example prints the namespace, release name and chart version that were deployed
    Given the example has been applied
    When the operator reads the example's outputs
    Then "kepler_namespace" is "kepler-system"
    And "kepler_release_name" is "kepler"
    And "kepler_chart_version" shows the chart version that was installed

  @id:deployment-outputs.usage-example.002 @rule:kepler.usage-example.requires-helm-provider-2x @inferred @source:examples/main.tf#terraform @questionable
  Scenario Outline: The example only runs with Helm provider 2.x and Terraform 1.0 or newer
    Given the operator's toolchain has <terraform> and Helm provider <helm_provider>
    When the operator initialises the example
    Then initialisation is <result>

    Examples:
      | terraform | helm_provider | result                                           |
      | 1.6.0     | 2.12.1        | accepted                                         |
      | 0.15.5    | 2.12.1        | refused for an unsupported Terraform version     |
      | 1.6.0     | 3.0.0         | refused because no Helm provider version matches |
