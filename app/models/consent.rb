class Consent < ApplicationRecord
<<<<<<< HEAD

  validates_presence_of :type_id, :description

  def get_type
    case self.type_id
    when 0
      return 'Terms'
    when 1
      return 'Contract'
    when 2
      return 'Cookies'
    end
  end

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
>>>>>>> b366e830c2f55b93d719fdac00d5e47be02cbef3
end
