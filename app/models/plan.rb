class Plan < Audit
  validate :date_validation

  scope :not_expired, -> { where("date > ?", Time.now) }

  def date_validation
    if self.date <= Time.now
      erros.add(:date, 'has to be in the future')
    end
  end
end
