class Plan < Audit
  belongs_to :auditor

  validates_presence_of :auditor, :price
  validates :date_validation

  def date_validation
    if self.date <= Time.now
      erros.add(:date, 'has to be in the future')
    end
  end
end
