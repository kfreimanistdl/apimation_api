@project
Feature:  As a User
          I want to create new project with multiple environments and Global variables and then delete environments

  Scenario: Create new project with 2 environments, each having 2 Global variables and delete environments
    When I login apimation.com as a regular user
    And I create new project
    And I select newly created project
    And I add new environment with name "DEV"
    And I add new environment with name "PROD"
    And I add 2 global variable for each environment
    And I delete all environments