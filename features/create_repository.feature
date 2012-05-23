Feature: Create Repositories
  As a project manager
  I want to be able to create a repository
  So that changes can be tracked

  Scenario: Create a valid repository
    Given I am on the new repository page
    When I enter valid repository details
    And I create the repository
    Then I should see a repository created message

  Scenario: Create an invalid repository
    Given I am on the new repository page
    When I enter invalid repository details
    And I create the repository
    Then I should see an error message