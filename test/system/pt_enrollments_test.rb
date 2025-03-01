require "application_system_test_case"

class PtEnrollmentsTest < ApplicationSystemTestCase
  setup do
    @pt_enrollment = pt_enrollments(:one)
  end

  test "visiting the index" do
    visit pt_enrollments_url
    assert_selector "h1", text: "Pt enrollments"
  end

  test "should create pt enrollment" do
    visit pt_enrollments_url
    click_on "New pt enrollment"

    fill_in "Course", with: @pt_enrollment.Course_id
    fill_in "Peerteacher", with: @pt_enrollment.PeerTeacher_id
    click_on "Create Pt enrollment"

    assert_text "Pt enrollment was successfully created"
    click_on "Back"
  end

  test "should update Pt enrollment" do
    visit pt_enrollment_url(@pt_enrollment)
    click_on "Edit this pt enrollment", match: :first

    fill_in "Course", with: @pt_enrollment.Course_id
    fill_in "Peerteacher", with: @pt_enrollment.PeerTeacher_id
    click_on "Update Pt enrollment"

    assert_text "Pt enrollment was successfully updated"
    click_on "Back"
  end

  test "should destroy Pt enrollment" do
    visit pt_enrollment_url(@pt_enrollment)
    click_on "Destroy this pt enrollment", match: :first

    assert_text "Pt enrollment was successfully destroyed"
  end
end
