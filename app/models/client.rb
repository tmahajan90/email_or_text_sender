class Client < ApplicationRecord
    scope :deliverable, -> { where(undeliverable: false) }
end
