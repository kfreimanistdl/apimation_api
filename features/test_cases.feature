@project
Feature:  As a User
          I want to create and execute new test cases

  Scenario: Create and execute new test case
    When I login apimation.com as a regular user
    And I select existing project
    And I create new request Collection
    And I add apimation login test steps
    Then test case is successfully created