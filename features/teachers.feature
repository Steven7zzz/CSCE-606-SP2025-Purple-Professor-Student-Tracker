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
    
    Scenario: Successfully adding a new teacher
  Given I am on the teachers index page
  When I click on "Add Teacher"
  And I fill in "First name" with "Alice"
  And I fill in "Last name" with "Smith"
  And I fill in "Uin" with "123456789"
  And I fill in "Department" with "Computer Science"
  And I fill in "Course & Semester" with "CSCE 606 - Spring 2025"
  And I fill in "Description" with "Expert in AI"
  And I fill in "Email" with "alice@example.com"
  And I click on "Add Teacher"
  Then I should be on the teachers index page
  And I should see "Alice"
  And I should see "Smith"
  And I should see "Computer Science"
  And I should see "CSCE 606 - Spring 2025"

Scenario: Failing to add a teacher due to missing required fields
  Given I am on the teachers index page
  When I click on "Add Teacher"
  And I fill in "First name" with "Bob"
  And I fill in "Last name" with ""
  And I fill in "Uin" with ""
  And I click on "Add Teacher"
  Then I should see "Last name can't be blank"
  And I should see "Uin can't be blank"





