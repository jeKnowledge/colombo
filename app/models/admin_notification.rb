class AdminNotification < ApplicationRecord
  def read
    self.update_attribute(:read, true)
  end
end
