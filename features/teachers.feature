Feature: View all teachers
  As a user
  I want to see a list of all teachers
  So that I can check who is available


    Scenario: Navigating back to the homepage
        Given I am on the teachers index page
        When I click on "Back to Homepage"
        Then I should be on the homepage
    
    Scenario: Navigating to the Teachers index page
        Given I am on the homepage
        When I click on "Teachers"
        Then I should be on the teachers index page
    
    Scenario: Adding a new teacher
        Given I am on the teachers index page
        When I click on "Add Teacher"
        Then I should be on the add teacher page
        When I fill in "First name" with "Camellia"
        And I fill in "Last name" with "J"
        And I fill in "Uin" with "1212121212"
        And I fill in "Department" with "Mathematics"
        And I fill in "Course & Semester" with "MATH 202 - Fall 2025"
        And I fill in "Description" with "Expert in simulation"
        And I click on "Add Teacher"
        Then I should be on the teachers index page
        And I should see "Camellia"
        And I should see "J"
        And I should see "1212121212"
        And I should see "Mathematics"
        And I should see "MATH 202 - Fall 2025"
        And I should see "Expert in simulation"



