Feature: User Logon
  As a user
  I want to be able to log in
  So that I can securely access my information

  Scenario: User Logon
    Given the following user exists:
      | username | email               | password |
      | Archytaus | atthealma@gmail.com | password |
    And I log in with "atthealma@gmail.com" and "password"
    Then I should see a log in success message

