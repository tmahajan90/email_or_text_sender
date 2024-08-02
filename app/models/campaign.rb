class Campaign < ApplicationRecord
  belongs_to :group

  enum status: { draft: 0, scheduled: 1, sent: 2, failed: 3 }
  validates :status, presence: true
end
