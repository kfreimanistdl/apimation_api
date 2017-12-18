@login
Feature: Test if user can login apimation.com

  Scenario: Login - positive
    When I login apimation.com as a regular user
    Then I check if I am logged in and I can access my personal information

  Scenario: Login - negative
    When I try to login apimation.com with a wrong password
    Then I check if I am not logged in and I cannot access my personal data