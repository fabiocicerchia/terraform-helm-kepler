@domain:configuration @area:release-naming @from:terraform-helm-kepler/variables
Feature: Naming the Kepler Helm release
  Lets an operator choose the Helm release name for the Kepler Operator, with a ready default so the module works with no inputs.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration

  @id:configuration.release-naming.001 @rule:kepler.release.name-defaults-to-kepler-operator @inferred @source:variables.tf#release_name
  Scenario Outline: The release is named kepler-operator unless the operator names it
    Given the operator <supplies> a release name
    When the operator applies the configuration
    Then the Kepler Operator Helm release is named "<release>"

    Examples:
      | supplies                  | release         |
      | does not supply           | kepler-operator |
      | supplies "kepler-prod" as | kepler-prod     |
