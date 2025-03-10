Feature: View all courses
  As a user
  I want to see a list of all courses
  So that I can manage course enrollments

Scenario: Navigating back to the homepage
  Given I am logged in 
  And I am on the courses index page
  When I click on "Back to Home" in the courses page
  Then I should be on the homepage

