class Report < Audit
  belongs_to :auditor

  validates_presence_of :rating, :auditor
end
