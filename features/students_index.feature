Feature: Viewing the students index page
  As a user
  I want to visit the students index page
  So that I can see a list of all students

  Scenario: Visiting the students index page and back to homepage
    Given I am logged in 
    Given I am on the students index page
    When I click on "Back to Home"
    Then I should be on the homepage
