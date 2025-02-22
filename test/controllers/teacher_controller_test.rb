require "test_helper"

class TeacherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teacher_index_url
    assert_response :success
  end
end
