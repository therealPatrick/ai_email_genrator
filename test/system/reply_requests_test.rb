require "application_system_test_case"

class ReplyRequestsTest < ApplicationSystemTestCase
  setup do
    @reply_request = reply_requests(:one)
  end

  test "visiting the index" do
    visit reply_requests_url
    assert_selector "h1", text: "Reply requests"
  end

  test "should create reply request" do
    visit reply_requests_url
    click_on "New reply request"

    fill_in "Ai reply", with: @reply_request.ai_reply
    fill_in "Email", with: @reply_request.email
    fill_in "Tone", with: @reply_request.tone
    fill_in "User", with: @reply_request.user_id
    click_on "Create Reply request"

    assert_text "Reply request was successfully created"
    click_on "Back"
  end

  test "should update Reply request" do
    visit reply_request_url(@reply_request)
    click_on "Edit this reply request", match: :first

    fill_in "Ai reply", with: @reply_request.ai_reply
    fill_in "Email", with: @reply_request.email
    fill_in "Tone", with: @reply_request.tone
    fill_in "User", with: @reply_request.user_id
    click_on "Update Reply request"

    assert_text "Reply request was successfully updated"
    click_on "Back"
  end

  test "should destroy Reply request" do
    visit reply_request_url(@reply_request)
    click_on "Destroy this reply request", match: :first

    assert_text "Reply request was successfully destroyed"
  end
end
