Given("I am on the Enrollments index page") do
  visit enrollments_path
end

When("I click on {string} in the enrollments page") do |button_text|
  expect(page).to have_link(button_text, wait: 5)
  click_link button_text
end
