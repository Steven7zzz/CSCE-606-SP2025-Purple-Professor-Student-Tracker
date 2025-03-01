require "application_system_test_case"

class PeerTeachersTest < ApplicationSystemTestCase
  setup do
    @peer_teacher = peer_teachers(:one)
  end

  test "visiting the index" do
    visit peer_teachers_url
    assert_selector "h1", text: "Peer teachers"
  end

  test "should create peer teacher" do
    visit peer_teachers_url
    click_on "New peer teacher"

    fill_in "Email", with: @peer_teacher.email
    fill_in "First name", with: @peer_teacher.first_name
    fill_in "Last name", with: @peer_teacher.last_name
    fill_in "Uin", with: @peer_teacher.uin
    click_on "Create Peer teacher"

    assert_text "Peer teacher was successfully created"
    click_on "Back"
  end

  test "should update Peer teacher" do
    visit peer_teacher_url(@peer_teacher)
    click_on "Edit this peer teacher", match: :first

    fill_in "Email", with: @peer_teacher.email
    fill_in "First name", with: @peer_teacher.first_name
    fill_in "Last name", with: @peer_teacher.last_name
    fill_in "Uin", with: @peer_teacher.uin
    click_on "Update Peer teacher"

    assert_text "Peer teacher was successfully updated"
    click_on "Back"
  end

  test "should destroy Peer teacher" do
    visit peer_teacher_url(@peer_teacher)
    click_on "Destroy this peer teacher", match: :first

    assert_text "Peer teacher was successfully destroyed"
  end
end
