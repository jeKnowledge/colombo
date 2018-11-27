class Message < ApplicationRecord
    belongs_to :source, class_name: "User", foreign_key: "source_id"
    belongs_to :destiny, class_name: "User", foreign_key: "destiny_id"
    belongs_to :audit

    scope :validated, -> { where(validated: true)}

    scope :paginate, -> (page, per_page) { page(page).per(per_page) }

    validates_presence_of :source, :destiny, :audit, :body
end
