class Plan < Audit
  belongs_to :auditor

  validates_presence_of :auditor, :price
end
