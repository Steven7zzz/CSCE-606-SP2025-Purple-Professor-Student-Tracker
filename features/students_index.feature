Feature: Viewing the students index page
  As a user
  I want to visit the students index page
  So that I can see a list of all students

  Scenario: Visiting the students index page
    Given a student exists
    When I visit the students index page
    Then I should see a successful response
