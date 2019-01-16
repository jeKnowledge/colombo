class Consent < ApplicationRecord
  # Callbacks
  def set_date
    self.update_attribute(:date, Date.today)
  end
end
