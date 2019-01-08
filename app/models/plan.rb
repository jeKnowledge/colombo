class Plan < Audit
  validate :date_validation

  has_many :reservations, dependent: :destroy

  scope :not_expired, -> { where("date > ?", Time.now) }

  def date_validation
    if self.date <= Time.now
      errors.add(:date, 'has to be in the future')
    end
  end
end
