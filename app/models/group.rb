class Group < ApplicationRecord
    belongs_to :user

    has_many :group_clients
    has_many :clients, through: :group_clients

    validates :name, uniqueness: { scope: :user_id, message: "has already been taken." }
end
