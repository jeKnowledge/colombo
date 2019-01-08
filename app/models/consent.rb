class Consent < ApplicationRecord
  validates_presence_of :type_id, :description

  scope :active, -> { where(active: true) }
  scope :terms, -> { where(type_id: 0) }

  TYPES = {
    0 => "Terms",
    1 => "Contract",
    2 => "Cookies"
  }
end
