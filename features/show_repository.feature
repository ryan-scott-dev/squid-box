Feature: Show Repository
  As a project member
  I want to be able to view a repository
  So that I can see information about that repository

  Background:
    Given the following repository exists:
      | name            |
      | Test Repository |
    And I am on the show repository page for "Test Repository"

  Scenario: See the commits of a repository
    Then I should see the repositories commits