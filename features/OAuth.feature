Feature: Google OAuth User Authentication

  Scenario: User exists and logs in with Google OAuth
    Given a user exists with email "authorized@example.com"
    When the user logs in with Google OAuth using email "authorized@example.com"
    Then the user should be logged in successfully

  Scenario: User does not exist and tries to log in with Google OAuth
    When the user logs in with Google OAuth using email "unauthorized@example.com"
    And the login attempt should fail

  Scenario: Google OAuth provides malformed data
    When the user logs in with Google OAuth using an empty email
    And the login attempt should fail
