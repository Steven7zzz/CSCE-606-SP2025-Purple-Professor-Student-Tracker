
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


When('I fill in {string} with {string}') do |field, value|
  field_name_map = {
    "First Name" => "teacher_first_name",
    "Last Name" => "teacher_last_name",
    "UIN" => "teacher_uin",
    "Department" => "teacher_department",
    "Course & Semester" => "teacher_course_and_semester",
    "Description" => "teacher_description",
    "Email" => "teacher_email"
  }
  field_id = field_name_map[field]
  
  if field_id
    fill_in field_id, with: value
  else
    raise "Could not find field with label '#{field}'"
  end
end
