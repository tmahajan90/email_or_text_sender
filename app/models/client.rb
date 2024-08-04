class Client < ApplicationRecord
    scope :deliverable, -> { where(undeliverable: false) }

    def personalize_email(template)
        template.gsub('%email%') if email
        template
    end
end
