class Client < ApplicationRecord
    scope :deliverable, -> { where(undeliverable: false) }

    def personalize_email(template)
        template.gsub('%email%') if email
        template.gsub('%name%') if name
        template.gsub('%mobile_no%') if mobile_no
        template
    end
end
