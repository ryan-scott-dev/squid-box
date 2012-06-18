Feature: User Logon
  As a user
  I want to be able to log in
  So that I can securely access my information

  Background:
    Given the following user exists:
      | login | email               | password | password_confirmation |
      | archy | atthealma@gmail.com | password | password              |

  Scenario: Successful Login
    When I log in with "archy" and "password"
    Then I should see a log in success message

  Scenario: Invalid login and valid password
    When I log in with "invalid" and "password"
    Then I should see a log in failed message

  Scenario: Valid login and invalid password
    When I log in with "archy" and "cars"
    Then I should see a log in failed message

  Scenario: Invalid login and invalid password
    When I log in with "invalid" and "carts"
    Then I should see a log in failed message