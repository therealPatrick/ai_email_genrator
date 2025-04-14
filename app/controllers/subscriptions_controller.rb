class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def new
    @subscription = current_user.build_subscription
  end

  def create
    paddle_service = PaddleService.new
    checkout_url = paddle_service.create_subscription_url(current_user)

    redirect_to checkout_url
  end

  def success
    paddle_service = PaddleService.new
    subscription = paddle_service.get_subscription(params[:subscription_id])

    if subscription && subscription['state'] == 'active'
      current_user.create_subscription(
        paddle_subscription_id: subscription['id'],
        status: 'active'
      )
      redirect_to reply_requests_path, notice: "Subscription activated successfully!"
    else
      redirect_to new_subscription_path, alert: "There was a problem activating your subscription. Please try again."
    end
  end

  def cancel
    redirect_to reply_requests_path, notice: "Subscription process cancelled."
  end

  def webhook
    paddle_service = PaddleService.new

    # Verify the webhook signature
    unless paddle_service.verify_webhook(request.body.read, request.headers['Paddle-Signature'])
      return head :unauthorized
    end

    payload = JSON.parse(request.body.read)

    case payload['alert_name']
    when 'subscription_created', 'subscription_updated'
      handle_subscription_update(payload)
    when 'subscription_cancelled'
      handle_subscription_cancellation(payload)
    end

    head :ok
  end

  private

  def handle_subscription_update(payload)
    user = User.find(payload['passthrough'])
    subscription = user.subscription || user.build_subscription

    subscription.update(
      paddle_subscription_id: payload['subscription_id'],
      status: payload['status']
    )
  end

  def handle_subscription_cancellation(payload)
    subscription = Subscription.find_by(paddle_subscription_id: payload['subscription_id'])
    subscription&.update(status: 'inactive')
  end
end
