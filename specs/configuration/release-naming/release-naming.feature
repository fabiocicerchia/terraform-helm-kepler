@domain:configuration @area:release-naming @from:terraform-helm-kepler/variables
Feature: Naming and placing the Kepler Helm release
  Lets an operator choose the Helm release name and namespace for the Kepler Operator, with a ready default so the module works with no inputs.

  Background:
    Given the operator calls the Kepler module from their Terraform or OpenTofu configuration

  @id:configuration.release-naming.001 @rule:kepler.release.name-defaults-to-kepler-operator @inferred @source:variables.tf#release_name
  Scenario Outline: The release is named kepler-operator in the kepler-operator namespace unless the operator chooses otherwise
    Given the operator <supplies> a release name
    And the operator <supplies_ns> a namespace
    When the operator applies the configuration
    Then the Kepler Operator Helm release is named "<release>"
    And it is installed in the "<namespace>" namespace

    Examples:
      | supplies                  | supplies_ns              | release         | namespace       |
      | does not supply           | does not supply          | kepler-operator | kepler-operator |
      | supplies "kepler-prod" as | supplies "monitoring" as | kepler-prod     | monitoring      |
