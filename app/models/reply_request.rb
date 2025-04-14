class ReplyRequest < ApplicationRecord
  belongs_to :user

  validates :email, presence: true, length: { maximum: 1000 }
  validates :tone, presence: true, inclusion: { in: %w[formal friendly concise professional casual] }
  validates :ai_reply, length: { maximum: 5000 }, allow_blank: true

  TONES = %w[formal friendly concise professional casual].freeze

  def self.tones
    TONES
  end
end
