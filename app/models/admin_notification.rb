class AdminNotification < ApplicationRecord
  def mark_as_read
    self.update_attribute(:read, true)
  end
end
