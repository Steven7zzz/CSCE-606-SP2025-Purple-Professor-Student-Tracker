require "application_system_test_case"

class StudentRostersTest < ApplicationSystemTestCase
  setup do
    @student_roster = student_rosters(:one)
  end

  test "visiting the index" do
    visit student_rosters_url
    assert_selector "h1", text: "Student rosters"
  end

  test "should create student roster" do
    visit student_rosters_url
    click_on "New student roster"

    fill_in "Class level", with: @student_roster.class_level
    fill_in "Email", with: @student_roster.email
    fill_in "Final", with: @student_roster.final
    fill_in "Major", with: @student_roster.major
    fill_in "Name", with: @student_roster.name
    fill_in "Uin", with: @student_roster.uin
    click_on "Create Student roster"

    assert_text "Student roster was successfully created"
    click_on "Back"
  end

  test "should update Student roster" do
    visit student_roster_url(@student_roster)
    click_on "Edit this student roster", match: :first

    fill_in "Class level", with: @student_roster.class_level
    fill_in "Email", with: @student_roster.email
    fill_in "Final", with: @student_roster.final
    fill_in "Major", with: @student_roster.major
    fill_in "Name", with: @student_roster.name
    fill_in "Uin", with: @student_roster.uin
    click_on "Update Student roster"

    assert_text "Student roster was successfully updated"
    click_on "Back"
  end

  test "should destroy Student roster" do
    visit student_roster_url(@student_roster)
    click_on "Destroy this student roster", match: :first

    assert_text "Student roster was successfully destroyed"
  end
end
