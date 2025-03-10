Feature: Viewing the Enrollments index page
  As a user
  I want to visit the Enrollments index page
  So that I can see a list of all Enrollments

  Scenario: Visiting the Enrollments index page and back to homepage
    Given I am logged in 
    Given I am on the Enrollments index page
    When I click on "Back to Home"
    Then I should be on the homepage