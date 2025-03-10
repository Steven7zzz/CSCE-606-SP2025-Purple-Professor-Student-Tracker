Given("I am on the courses index page") do
  visit courses_path  
end

When("I click on {string} in the courses page") do |button_text|
  puts page.html  # ✅ 打印页面 HTML，检查 "Back to Home" 是否真的存在
  expect(page).to have_link(button_text, wait: 5)
  click_link button_text
end


Given("I am logged in") do
  user = User.create!(email: "test@example.com", password: "password")
  login_as(user, scope: :user)
end







