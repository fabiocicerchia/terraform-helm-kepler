@domain:developer-tooling @area:compatibility @from:terraform-helm-kepler/versions
Feature: Declaring supported Terraform, OpenTofu and Helm provider versions
  Tells operators calling the module which Terraform/OpenTofu releases and Helm provider versions it works with, so incompatible toolchains are refused at init time rather than failing mid-deploy.

  Background:
    Given the operator's root configuration calls the Kepler module

  @id:developer-tooling.compatibility.001 @rule:compatibility.toolchain.minimum-terraform-version @inferred @source:versions.tf#terraform
  Scenario Outline: Terraform or OpenTofu older than 1.0 is refused
    Given the operator's CLI is <cli> version <cli_version>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | cli       | cli_version | outcome                                                                     |
      | Terraform | 0.15.5      | is refused with an unsupported Terraform Core version error naming ">= 1.0" |
      | Terraform | 1.0.0       | proceeds                                                                    |
      | Terraform | 1.9.8       | proceeds                                                                    |
      | OpenTofu  | 1.6.0       | proceeds                                                                    |

  @id:developer-tooling.compatibility.002 @rule:compatibility.toolchain.minimum-helm-provider-version @inferred @source:versions.tf#terraform @questionable
  Scenario Outline: The module needs the hashicorp/helm provider at version 2.0 or later
    Given the operator's configuration constrains the hashicorp/helm provider to <constraint>
    When the operator initialises the configuration
    Then initialisation <outcome>

    Examples:
      | constraint    | outcome                                                                                                        |
      | "< 2.0"       | is refused because no helm provider version satisfies both the operator's constraint and the module's ">= 2.0" |
      | "~> 2.0"      | proceeds with a 2.x helm provider                                                                              |
      | no constraint | proceeds with the newest helm provider, including 3.x                                                          |
