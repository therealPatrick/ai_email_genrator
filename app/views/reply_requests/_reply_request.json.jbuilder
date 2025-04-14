json.extract! reply_request, :id, :user_id, :email, :tone, :ai_reply, :created_at, :updated_at
json.url reply_request_url(reply_request, format: :json)
