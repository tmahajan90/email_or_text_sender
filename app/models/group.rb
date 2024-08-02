class Group < ApplicationRecord
    belongs_to :user

    has_many :groups
    has_many :campaigns
    has_many :group_clients
    has_many :clients, through: :group_clients

    validates :name, uniqueness: { scope: :user_id, message: "has already been taken." }

    before_destroy :check_for_campaigns

    private

    # Callback method to prevent deletion if associated campaigns exist
    def check_for_campaigns
        if campaigns.exists?
            errors.add(:base, "Cannot delete group with associated campaigns")
            throw(:abort) # Prevents the record from being destroyed
        end
    end
end
