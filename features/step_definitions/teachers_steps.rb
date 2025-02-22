
Given('the following teachers exist:') do |table|
  table.hashes.each do |teacher|
    Teacher.create!(
      first_name: teacher['First Name'],
      last_name: teacher['Last Name'],
      uin: teacher['UIN'],
      department: teacher['Department'],
      course_and_semester: teacher['Course & Semester'],
      description: teacher['Description']
    )
end
end

When('I am on the teachers index page') do
  visit teachers_path
end

Then('I should see {string}') do |text|
  expect(page).to have_content(text) 
end

When('I click on {string}') do |element_text|
  if page.has_link?(element_text)
    click_link element_text
  elsif page.has_button?(element_text)
    click_button element_text
  else
    raise "Could not find a link or button with text '#{element_text}'"
  end
end

Then('I should be on the homepage') do
  expect(current_path).to eq(root_path)
end

Given('I am on the homepage') do
  visit root_path  
end


Then('I should be on the teachers index page') do
  expect(current_path).to eq(teachers_path)  
end


Then('I should be on the add teacher page') do
  expect(current_path).to eq(new_teacher_path)
end

Given(/^a teacher "(.*)" exists with UIN "(.*)"$/) do |name, uin|
  first_name, last_name = name.split(" ")
  Teacher.create!(
    first_name: first_name,
    last_name: last_name,
    uin: uin,
    department: "Computer Science",
    course_and_semester: "CSCE 606 - Spring 2025",
    description: "Expert in AI",
    email: "alice@example.com"
  )
end

When(/^I fill in "(.*)" with "(.*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I visit (.*)'s profile page$/) do |name|
  teacher = Teacher.find_by(first_name: name.split(" ").first)
  visit teacher_path(teacher)
end

When(/^I delete "(.*)"$/) do |name|
  teacher = Teacher.find_by(first_name: name.split(" ").first)
  visit teachers_path
  within("tr", text: teacher.first_name) do
    click_link "Delete"
  end
end

Then(/^I should not see "(.*)" on the teachers index page$/) do |name|
  visit teachers_path
  expect(page).not_to have_content(name)
end

