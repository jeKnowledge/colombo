class Consent < ApplicationRecord
<<<<<<< HEAD

=======
>>>>>>> 1c36ab542a7678610aab1b678dd49a24c7ed564d
  validates_presence_of :type_id, :description

  scope :active, -> { where(active: true) }
  scope :terms, -> { where(type_id: 0) }

<<<<<<< HEAD
  def self.get_type_id(type)
    case type
    when 'Terms'
      return 0
    when 'Contract'
      return 1
    when 'Cookies'
      return 2
    end
  end
=======
  TYPES = {
    0 => "Terms",
    1 => "Contract",
    2 => "Cookies"
  }
>>>>>>> 1c36ab542a7678610aab1b678dd49a24c7ed564d
end
