Given("a student exists") do
  @student = Student.create(first_name: "John", last_name: "Doe", major: "Computer Science", email: "john.doe@example.com")
end

When("I visit the students index page") do
  visit students_path
end

Then("I should see a successful response") do
  expect(page).to have_content("Students")
end

Given("I am on the students index page") do
  visit students_path
end
