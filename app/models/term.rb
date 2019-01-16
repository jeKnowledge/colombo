class Term < Consent
  # Methods
  def select
    Term.update_all(active: false)
    self.update_attribute(:active, true)
  end
end