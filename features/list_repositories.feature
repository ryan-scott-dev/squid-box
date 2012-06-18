Feature: Show a list of the repositories
  As a project member
  I want to see a list of all the repositories I have access to
  So that I can open one that I want to see

  Scenario: See a repository
    Given the following repository exists:
      | name            |
      | Test Repository |
    When I visit the repository page
    Then I should see the repository "Test Repository"