require "test_helper"

class PtEnrollmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pt_enrollment = pt_enrollments(:one)
  end

  test "should get index" do
    get pt_enrollments_url
    assert_response :success
  end

  test "should get new" do
    get new_pt_enrollment_url
    assert_response :success
  end

  test "should create pt_enrollment" do
    assert_difference("PtEnrollment.count") do
      post pt_enrollments_url, params: { pt_enrollment: { Course_id: @pt_enrollment.Course_id, PeerTeacher_id: @pt_enrollment.PeerTeacher_id } }
    end

    assert_redirected_to pt_enrollment_url(PtEnrollment.last)
  end

  test "should show pt_enrollment" do
    get pt_enrollment_url(@pt_enrollment)
    assert_response :success
  end

  test "should get edit" do
    get edit_pt_enrollment_url(@pt_enrollment)
    assert_response :success
  end

  test "should update pt_enrollment" do
    patch pt_enrollment_url(@pt_enrollment), params: { pt_enrollment: { Course_id: @pt_enrollment.Course_id, PeerTeacher_id: @pt_enrollment.PeerTeacher_id } }
    assert_redirected_to pt_enrollment_url(@pt_enrollment)
  end

  test "should destroy pt_enrollment" do
    assert_difference("PtEnrollment.count", -1) do
      delete pt_enrollment_url(@pt_enrollment)
    end

    assert_redirected_to pt_enrollments_url
  end
end
