class Consent < ApplicationRecord

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
end
