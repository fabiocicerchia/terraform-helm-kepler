@domain:kepler-deployment @area:namespace-placement @from:terraform-helm-kepler/variables
Feature: Choosing the Kepler namespace
  Lets an operator place the Kepler Operator in a namespace of their choice, defaulting to kepler-operator.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration

  @id:kepler-deployment.namespace-placement.001 @rule:kepler.namespace.defaults-to-kepler-operator @inferred @source:variables.tf#namespace
  Scenario Outline: Kepler is installed in the kepler-operator namespace unless the operator picks another
    Given the operator <supplies> a namespace
    When the operator applies the configuration
    Then the Kepler Operator is installed in the "<namespace>" namespace

    Examples:
      | supplies                 | namespace       |
      | does not supply          | kepler-operator |
      | supplies "monitoring" as | monitoring      |
