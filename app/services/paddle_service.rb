class PaddleService
  def initialize
    @client = Paddle::Client.new(
      vendor_id: ENV['PADDLE_VENDOR_ID'],
      vendor_auth_code: ENV['PADDLE_VENDOR_AUTH_CODE']
    )
  end

  def create_subscription_url(user)
    @client.subscription.create(
      plan_id: ENV['PADDLE_PRODUCT_ID'],
      customer_email: user.email,
      passthrough: user.id.to_s,
      success_url: Rails.application.routes.url_helpers.subscriptions_success_url,
      cancel_url: Rails.application.routes.url_helpers.subscriptions_cancel_url
    )
  end

  def verify_webhook(payload, signature)
    @client.webhook.verify(payload, signature)
  end

  def get_subscription(subscription_id)
    @client.subscription.get(subscription_id)
  end
end
