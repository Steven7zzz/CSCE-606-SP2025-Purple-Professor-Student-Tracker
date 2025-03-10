Feature: View all teachers
  As a user
  I want to see a list of all teachers
  So that I can check who is available

    Scenario: Navigating back to the homepage
        Given I am logged in 
        Given I am on the peer teachers index page
        When I click on "Back to Home"
        Then I should be on the homepage
    
    Scenario: Navigating to the Teachers index page
        Given I am logged in 
        Given I am on the homepage
        When I click on "Peer Teachers"
        Then I should be on the teachers index page
    








