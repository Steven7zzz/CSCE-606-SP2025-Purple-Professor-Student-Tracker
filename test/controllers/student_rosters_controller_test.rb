require "test_helper"

class StudentRostersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_roster = student_rosters(:one)
  end

  test "should get index" do
    get student_rosters_url
    assert_response :success
  end

  test "should get new" do
    get new_student_roster_url
    assert_response :success
  end

  test "should create student_roster" do
    assert_difference("StudentRoster.count") do
      post student_rosters_url, params: { student_roster: { class_level: @student_roster.class_level, email: @student_roster.email, final: @student_roster.final, major: @student_roster.major, name: @student_roster.name, uin: @student_roster.uin } }
    end

    assert_redirected_to student_roster_url(StudentRoster.last)
  end

  test "should show student_roster" do
    get student_roster_url(@student_roster)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_roster_url(@student_roster)
    assert_response :success
  end

  test "should update student_roster" do
    patch student_roster_url(@student_roster), params: { student_roster: { class_level: @student_roster.class_level, email: @student_roster.email, final: @student_roster.final, major: @student_roster.major, name: @student_roster.name, uin: @student_roster.uin } }
    assert_redirected_to student_roster_url(@student_roster)
  end

  test "should destroy student_roster" do
    assert_difference("StudentRoster.count", -1) do
      delete student_roster_url(@student_roster)
    end

    assert_redirected_to student_rosters_url
  end
end
