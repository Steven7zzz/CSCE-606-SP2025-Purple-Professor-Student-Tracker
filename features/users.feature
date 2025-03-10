Feature: View all users
  As a user
  I want to see a list of all users
  So that I can check who is available

    Scenario: Navigating back to the homepage
        Given I am logged in 
        Given I am on the users index page
        When I click on "Back to Home"
        Then I should be on the homepage