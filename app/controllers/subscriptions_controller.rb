class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @subscription = current_user.build_subscription
  end

  def create
    # TODO: Implement Paddle checkout
    # For now, we'll simulate a successful subscription
    @subscription = current_user.build_subscription(
      paddle_subscription_id: "sub_#{SecureRandom.hex(10)}",
      status: 'active'
    )

    if @subscription.save
      redirect_to reply_requests_path, notice: "Subscription activated successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def webhook
    # TODO: Implement Paddle webhook handling
    # This will handle subscription updates, cancellations, etc.
    head :ok
  end
end
