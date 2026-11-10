@domain:configuration @area:chart-values @from:terraform-helm-kepler/variables
Feature: Passing Helm values to the Kepler chart
  Lets an operator tune the Kepler Operator by handing arbitrary Helm values straight to the chart.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration

  @id:configuration.chart-values.001 @rule:kepler.chart.values-passed-through-unchanged @inferred @source:variables.tf#values
  Scenario Outline: Operator-supplied Helm values reach the Kepler chart unchanged
    Given the operator supplies the values <values>
    When the operator applies the configuration
    Then the Kepler Operator chart is rendered with <rendered>

    Examples:
      | values                          | rendered                      |
      | nothing                         | the chart's own defaults only |
      | { operator = { replicas = 2 } } | operator.replicas set to 2    |
