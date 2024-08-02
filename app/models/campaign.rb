class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum status: { scheduled: 0, sending: 1, sent: 2, failed: 3 }
  validates :status, presence: true
end
