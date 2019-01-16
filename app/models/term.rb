class Term < ApplicationRecord
  # Methods
  def select
    Term.update_all(active: false)
    self.update_attribute(:active, true)
  end

  # Callbacks
  def set_date
    self.update_attribute(:date, Date.today)
  end
end
