class Subscription < ApplicationRecord
  belongs_to :user

  validates :paddle_subscription_id, presence: true
  validates :status, presence: true, inclusion: { in: %w[active inactive] }

  def active?
    status == 'active'
  end
end
