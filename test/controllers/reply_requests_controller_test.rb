require "test_helper"

class ReplyRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reply_request = reply_requests(:one)
  end

  test "should get index" do
    get reply_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_reply_request_url
    assert_response :success
  end

  test "should create reply_request" do
    assert_difference("ReplyRequest.count") do
      post reply_requests_url, params: { reply_request: { ai_reply: @reply_request.ai_reply, email: @reply_request.email, tone: @reply_request.tone, user_id: @reply_request.user_id } }
    end

    assert_redirected_to reply_request_url(ReplyRequest.last)
  end

  test "should show reply_request" do
    get reply_request_url(@reply_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_reply_request_url(@reply_request)
    assert_response :success
  end

  test "should update reply_request" do
    patch reply_request_url(@reply_request), params: { reply_request: { ai_reply: @reply_request.ai_reply, email: @reply_request.email, tone: @reply_request.tone, user_id: @reply_request.user_id } }
    assert_redirected_to reply_request_url(@reply_request)
  end

  test "should destroy reply_request" do
    assert_difference("ReplyRequest.count", -1) do
      delete reply_request_url(@reply_request)
    end

    assert_redirected_to reply_requests_url
  end
end
