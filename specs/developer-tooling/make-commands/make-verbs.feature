@domain:developer-tooling @area:make-commands @from:terraform-helm-kepler/makefile
Feature: Running the standard make verbs
  Gives contributors the same make verbs in every repository, so they can set up, check and test the module without reading the Makefile, and every verb either works, says why it does not apply, or fails loudly.

  Background:
    Given Given a contributor has a checkout of the Kepler module repository

  @id:developer-tooling.make-commands.001 @rule:tooling.make.bare-make-lists-verbs @inferred @source:Makefile#help
  Scenario: Running make with no verb lists the available verbs
    When When the contributor runs make with no verb
    Then Then they see one line per verb: help, setup, install, lint, format, test, analyze, build and run
    And And each line shows the verb followed by its one-line description, such as "test  Validate the module and its examples"
    And And nothing is installed, formatted or validated

  @id:developer-tooling.make-commands.002 @rule:tooling.make.not-applicable-verbs-explain-themselves @inferred @source:Makefile#build
  Scenario Outline: A verb that does not apply to a Terraform module says why instead of pretending to work
    When When the contributor runs make <verb>
    Then Then they see "<message>"
    And And they see "See README > Not applicable."
    And And the command exits with status 0

    Examples:
      | verb  | message                                                                  |
      | build | Nothing to build: this is a Terraform module, consumed from source.      |
      | run   | Nothing to run: a module is called by a root module, never run directly. |

  @id:developer-tooling.make-commands.003 @rule:tooling.make.analyze-refuses-without-tflint @inferred @source:Makefile#analyze
  Scenario: Static analysis refuses to run when TFLint is not installed
    Given Given TFLint is not installed on the contributor's machine
    When When the contributor runs make analyze
    Then Then they see "analyze needs tflint: https://github.com/terraform-linters/tflint" on the error output
    And And the command exits with status 69
    And And no lint results are reported

  @id:developer-tooling.make-commands.004 @rule:tooling.make.test-validates-module-and-example @inferred @source:Makefile#test @questionable
  Scenario: Testing validates both the module and its usage example
    When When the contributor runs make test
    Then Then the module's Terraform configuration is validated without touching any remote state
    And And the usage example in examples/ is validated as well
    And And the command fails if either configuration is invalid
