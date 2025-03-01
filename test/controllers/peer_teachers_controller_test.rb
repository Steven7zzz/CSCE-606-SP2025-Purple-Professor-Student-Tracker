require "test_helper"

class PeerTeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @peer_teacher = peer_teachers(:one)
  end

  test "should get index" do
    get peer_teachers_url
    assert_response :success
  end

  test "should get new" do
    get new_peer_teacher_url
    assert_response :success
  end

  test "should create peer_teacher" do
    assert_difference("PeerTeacher.count") do
      post peer_teachers_url, params: { peer_teacher: { email: @peer_teacher.email, first_name: @peer_teacher.first_name, last_name: @peer_teacher.last_name, uin: @peer_teacher.uin } }
    end

    assert_redirected_to peer_teacher_url(PeerTeacher.last)
  end

  test "should show peer_teacher" do
    get peer_teacher_url(@peer_teacher)
    assert_response :success
  end

  test "should get edit" do
    get edit_peer_teacher_url(@peer_teacher)
    assert_response :success
  end

  test "should update peer_teacher" do
    patch peer_teacher_url(@peer_teacher), params: { peer_teacher: { email: @peer_teacher.email, first_name: @peer_teacher.first_name, last_name: @peer_teacher.last_name, uin: @peer_teacher.uin } }
    assert_redirected_to peer_teacher_url(@peer_teacher)
  end

  test "should destroy peer_teacher" do
    assert_difference("PeerTeacher.count", -1) do
      delete peer_teacher_url(@peer_teacher)
    end

    assert_redirected_to peer_teachers_url
  end
end
