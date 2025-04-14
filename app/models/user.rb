class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reply_requests, dependent: :destroy
  has_one :subscription, dependent: :destroy

  def remaining_free_replies
    [3 - reply_requests.count, 0].max
  end

  def can_generate_reply?
    subscription&.active? || remaining_free_replies > 0
  end
end
